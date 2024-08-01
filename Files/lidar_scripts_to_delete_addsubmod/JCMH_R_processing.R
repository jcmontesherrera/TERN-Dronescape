library(lidR)
library(RCSF)
library(future)
library(profvis)
library(terra)
library(raster)
library(dplyr)
library(purrr)
library(gdalUtilities)
library(ggplot2)
library(mapview)
library(mapedit)
library(viridis)
library(RColorBrewer)

# Setup for parallel processing using half of available cores
plan(multisession, workers = availableCores()/2)
set_lidr_threads(availableCores()/2)

# Define directories for input and output
in_dir <- in_dir <- "C:/Users/jcmontes/Documents/DJI/DJITerra/jcmontesh@gmail.com/20240313_SASMDD0008(1)/lidars/terra_las"
out_dir <- "C:/Users/jcmontes/Documents/DJI/Outputs"
tmp_dir <- out_dir

gnd_dir = paste(file.path(tmp_dir),"01_csf_gnd\\", sep="")
norm_dir = paste(file.path(tmp_dir), "02_ht_norm\\", sep="")
chm_dtm_dir = paste(file.path(tmp_dir), "03_chm_dtm\\", sep="")
metrics_dir = paste(file.path(tmp_dir), "04_metrics\\", sep="")

# Functions for processing
plot_transect <- function(las, p1, p2, width) {
  data_clip <- clip_transect(las, p1, p2, width, xz=TRUE)
  p <- ggplot(data_clip@data, aes(X, Z, color = Z)) + 
    geom_point(size = 0.5) + 
    coord_equal() + 
    theme_minimal() +
    scale_color_gradientn(colours = plasma(50))
  return(p)
}

# Function to calculate canopy cover
canopyCover <- function(z, rn) {
  first = rn == 1L
  zfirst = z[first]
  num_first_rtns = length(zfirst)
  first_above_thres = sum(zfirst > 1.4)  # HARDCODED height threshold 1.4 m
  x = (first_above_thres / num_first_rtns)  # output as fraction 
  return(x)
}

# Function to calculate canopy density
canopyDensity <- function(z){
  num_rtns = length(z)
  num_above_thres = sum(z > 1.4) # Counts returns above the height threshold of 1.4 meters
  x = num_above_thres / num_rtns # Calculates the fraction of returns above the threshold
  return(x)
}

# Function to read Z values from chunks
func_read_z <- function(chunk){
  las <- readLAS(chunk)
  if(is.null(las) || nrow(las) == 0) return(NULL)  # Checks if the LAS chunk is empty or has no points
  df <- data.frame(Z = las$Z)
  return(df)
}

# Read the LASCatalog from the input directory
ctg <- readLAScatalog(in_dir)

# Create spatial indexing if not already present
if(length(list.files(path = in_dir, pattern = "\\.lax$")) == 0) {
  lidR:::catalog_laxindex(ctg)
}

# Classify ground points using Cloth Simulation Filter (CSF)
mycsf <- csf(sloop_smooth=FALSE, cloth_resolution = 0.2, iterations = 500, class_threshold = 0.1)
opt_output_files(ctg) <- paste0(tmp_dir, "01_csf_gnd_{ID}")
opt_chunk_size(ctg) <- 100
opt_chunk_buffer(ctg) <- 10 
opt_progress(ctg) <- FALSE

# Apply ground classification and index
ctg_gnd_classified <- classify_ground(ctg, mycsf, last_returns = FALSE)
lidR:::catalog_laxindex(ctg_gnd_classified)

# Generate Digital Terrain Model (DTM)
opt_output_files(ctg_gnd_classified) <- paste0(tmp_dir, "03_chm_dtm/dtm_idw_{ID}")
dtm_raster <- rasterize_terrain(ctg_gnd_classified, res=0.05, algorithm = knnidw(k = 10L, p = 2))
writeRaster(dtm_raster, file.path(out_dir, "dtm_raster_05.tif"), filetype="GTiff")

# Normalize point cloud heights
opt_output_files(ctg_gnd_classified) <- paste0(tmp_dir, "02_ht_norm/ht_norm_{ID}")
ctg_norm <- normalize_height(ctg_gnd_classified, knnidw(k=10, p=2))
lidR:::catalog_laxindex(ctg_norm)

# Generate Canopy Height Model (CHM)
opt_output_files(ctg_norm) <- paste0(tmp_dir, "03_chm_dtm/chm_{ID}")
chm_p2r_ctg <- rasterize_canopy(ctg_norm, res=0.05, p2r(0.2))
writeRaster(chm_p2r_ctg, file.path(out_dir, "chm_p2r20_05.tif"), filetype="GTiff")
plot(chm_p2r_ctg, col = viridis(10))

# Calculate and plot canopy cover and density metrics
opt_output_files(ctg_norm) <- paste0(out_dir, "metrics_{ID}")
canopy_cover <- pixel_metrics(ctg_norm, ~canopyCover(Z, rn=ReturnNumber), res = 1)
writeRaster(canopy_cover, file.path(out_dir, "canopy_cover_1m.tif"), filetype="GTiff")

opt_output_files(ctg_norm) <-paste(chm_dtm_dir, "cdns_{ID}", sep="")
canopy_density <- pixel_metrics(ctg_norm, ~canopyDensity(Z), res = 1)
writeRaster(canopy_density, file.path(out_dir, "canopy_dns_1m.tif"), filetype="GTiff")
plot(canopy_cover, col = viridis(20))

# Set catalog processing options
options <- list(automerge = TRUE, need_buffer = FALSE)
opt_filter(ctg_norm) <- "-drop_z_below 1.5"  # Filters out returns below 1.5m
opt_chunk_buffer(ctg_norm) <- 0  # No buffer needed for this operation

# Apply the function to each chunk in the LAScatalog
df <- catalog_apply(ctg_norm, func_read_z, .options = options)

# Handle the case where 'catalog_apply' might return file paths instead of a data frame
if(is.character(df)) {
  df <- df %>% map_df(~ read.csv(.x, sep = ""))
}

# Plotting vertical profile as a histogram
# Check for NA or infinite values and remove them if necessary

# Plotting vertical profile as a histogram
ggplot(df, aes(x = Z)) +
  geom_histogram(bins = 30,  # You may adjust the number of bins for better data representation
                 aes(y = ..count../sum(..count..)),
                 colour = "black", fill = "white") +
  scale_y_continuous("Percentage of Points", labels = scales::percent_format()) +
  scale_x_continuous("Height (m)") +
  theme_bw() +
  theme(strip.background = element_blank(), panel.border = element_rect(colour = "black")) +
  coord_flip()

# Plotting vertical profile as a frequency polygon
ggplot(df, aes(x = Z)) +
  geom_freqpoly(aes(y = ..count../sum(..count..)),  # directly use proportion
                binwidth = 1,  # Adjust binwidth as necessary to fit the data density
                colour = "black", fill = "white") +
  scale_y_continuous("Percentage of Points", labels = scales::percent_format()) +  # Properly label and format the y-axis
  scale_x_continuous("Height (m)") +  # x-axis remains labeled as 'Height (m)'
  theme_bw() +
  theme(strip.background = element_blank(), panel.border = element_rect(colour = "black")) +
  coord_flip()

