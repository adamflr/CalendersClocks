# Example data
flowers <- c("Achillea millefolium", "Aegopodium podagraria", "Allium oleraceum", 
             "Anemone nemorosa", "Anthriscus sylvestris", "Armeria maritima")

set.seed(190522)
dat <- data.frame(flowers = flowers, counts = rpois(6, 25))
rm(flowers)
dat
