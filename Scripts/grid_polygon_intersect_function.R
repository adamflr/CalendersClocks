# Function to set picture in polygon, produces the intersected spatial object
# Import as image, transform to sf, keep color data, make grid in sf, plot
# Packages ----
library(dplyr)
library(rgdal)
library(sf)
library(ggplot2)
library(cowplot)

# Import image ----
set_img_in_polygon <- function(img_path, polygon){
  # Import image
  img <- readGDAL(img_path, silent = T)
  
  # Set geometry and make grid
  img_sf <- st_as_sf(img)
  img_grid <- st_make_grid(img_sf, cellsize = 1)
  
  # Sort grid to correspond to image
  grid_sort <- expand.grid(x = 1:st_bbox(img_grid)$xmax, y = 1:st_bbox(img_grid)$ymax)
  st_geometry(grid_sort) <- img_grid
  grid_sort %>% arrange(desc(y), x) -> grid_sort
  st_geometry(img_sf) <- st_geometry(grid_sort)
  
  # Extract borders of polygon and transform image to correspond
  bbox_pol <- st_bbox(polygon)
  cent_pol <- matrix(c(bbox_pol[1] + bbox_pol[3], bbox_pol[2] + bbox_pol[4]), 1, 2)/ 2
  hw_ratio_pol <- (bbox_pol[4] - bbox_pol[2]) / (bbox_pol[3] - bbox_pol[1])
  
  bbox_img <- st_bbox(img_sf)
  cent_img <- matrix(c(bbox_img[1] + bbox_img[3], bbox_img[2] + bbox_img[4]), 1, 2)/ 2
  hw_ratio_img <- (bbox_img[4] - bbox_img[2]) / (bbox_img[3] - bbox_img[1])
  
  scaling <- ifelse(hw_ratio_pol > hw_ratio_img, 
                    (bbox_pol[4] - bbox_pol[2]) / (bbox_img[4] - bbox_img[2]),
                    (bbox_pol[3] - bbox_pol[1]) / (bbox_img[3] - bbox_img[1]))
  img_sf <- img_sf %>% mutate(geometry = geometry - cent_img,
                              geometry = geometry * scaling,
                              geometry = geometry + cent_pol)
  
  # Intersect polygon and image
  st_intersection(img_sf, polygon) %>% 
    filter(!st_is(geometry, "POINT")) -> img_sf_int
  
  # Print spatial intersection
  img_sf_int
}

pol <- st_polygon(list(matrix(c(0,0,1,0,1,1,0,1,0,0), ncol = 2, byrow = T)))
set_img_in_polygon("Example pictures/Kurre6.jpg", pol * matrix(c(1, 5), 1, 2)) %>% plot()
