SpatialPolygons2df <- function(sp){
  extract_pol_at_i <- function(x){sp@polygons[[x]]@Polygons[[1]]@coords}
  dat_pol_gg <- data.frame()
  for(i in 1:length(sp@polygons)){
    data.frame(extract_pol_at_i(i), id = i) %>% 
      rbind(dat_pol_gg) -> dat_pol_gg
  }
  dat_pol_gg
}

ggplot(sp_df, aes(long, lat)) + 
  geom_point(color = rgb(sp_df$band1/360, sp_df$band2/360, sp_df$band3/360), size = 5)

