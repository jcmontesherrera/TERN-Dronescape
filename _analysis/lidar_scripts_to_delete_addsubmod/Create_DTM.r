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
plan(multisession, workers = availableCores() / 2)
set_lidr_threads(availableCores() / 2)

# Define directories for input and output
in_dir <- in_dir <- "C:/Users/jcmontes/Documents/01_Projects-JC-Terraluma/TERN-Dronescape/local-tests/Calperum013/lidars/terra_las/"
out_dir <- "C:/Users/jcmontes/Desktop/Calperum013_lidar/"
tmp_dir <- out_dir

gnd_dir <- paste(file.path(tmp_dir), "01_csf_gnd\\", sep = "")
norm_dir <- paste(file.path(tmp_dir), "02_ht_norm\\", sep = "")
chm_dtm_dir <- paste(file.path(tmp_dir), "03_chm_dtm\\", sep = "")
metrics_dir <- paste(file.path(tmp_dir), "04_metrics\\", sep = "")

# Read the LASCatalog from the input directory
ctg <- readLAScatalog(in_dir)

# Create spatial indexing if not already present
if (length(list.files(path = in_dir, pattern = "\\.lax$")) == 0) {
    lidR:::catalog_laxindex(ctg)
}

# Classify ground points using Cloth Simulation Filter (CSF)
mycsf <- csf(sloop_smooth = FALSE, cloth_resolution = 1.0, iterations = 500, class_threshold = 0.005)
opt_output_files(ctg) <- paste0(tmp_dir, "01_csf_gnd_{ID}")
opt_chunk_size(ctg) <- 100
opt_chunk_buffer(ctg) <- 10
opt_progress(ctg) <- FALSE

# Apply ground classification and index
ctg_gnd_classified <- classify_ground(ctg, mycsf, last_returns = FALSE)
lidR:::catalog_laxindex(ctg_gnd_classified)

# Generate Digital Terrain Model (DTM)
opt_output_files(ctg_gnd_classified) <- paste0(tmp_dir, "03_chm_dtm/dtm_idw_{ID}")
dtm_raster <- rasterize_terrain(ctg_gnd_classified, res = 0.05, algorithm = knnidw(k = 10L, p = 2))
writeRaster(dtm_raster, file.path(out_dir, "clothres1.0_classthresh005-dtm_raster_05.tif"), filetype = "GTiff")
