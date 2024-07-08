library(ausplotsR)

lapply(names(my.data), function(x) {
  write.csv(my.data[[x]], paste0(x, ".csv"), row.names = FALSE)
}) # Wrote 2 csv files


# Read the CSV file
plot_ids <- read.csv("C:/Users/jcmontes/Documents/GitHub/TERN-Dronescape/Files/Broken-Hill-Complex-plots.csv"
                     , header = FALSE)

# Flatten the data frame to a single vector of plot IDs
plot_ids_vector <- as.vector(t(plot_ids))

# Fetch the data using the plot IDs from the CSV file
my.data <- get_ausplots(my.Plot_IDs = plot_ids_vector, veg.PI = TRUE, site_info = TRUE)


ausplots_trajectory(my.data, choices = "PCoA")

fractional_cover(my.data$veg.PI)
basal_area(my.data$veg.basal) #didnt work

tree.cover <- single_cover_value(my.data$veg.PI)
tree.cover #no data

growth_form_table(my.data$veg.PI, m_kind="percent_cover", cover_type="PFC",
                  cumulative=FALSE, species_name="SN")

growth_form_table(my.data$veg.PI, m_kind="percent_cover", 
                  cover_type="PFC", cumulative=FALSE, by_strata=TRUE, species_name="SN")

species_table(my.data$veg.PI, m_kind="percent_cover", cover_type="PFC", 
              species_name="GS")

ausplots_visual(my.data, map = TRUE, map.attribute = TRUE, 
                fraction.pie = TRUE, growthform.pie = TRUE, cumulative.cover = TRUE, 
                whittaker = TRUE, outfile = "AusPlots_treeCover.pdf", 
                max.plots=length(unique(my.data$veg.PI$site_location_name)))
