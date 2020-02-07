# Importing pictures, reducing size, put together
library(magick)
im <- c("Achillea millefolium.jpg", "Aegopodium podagraria.jpg", "Allium oleraceum.jpg", 
        "Anemone nemorosa.jpg", "Anthriscus sylvestris.jpg", "Armeria maritima.jpg")


im1 <- image_read("Example pictures/Achillea millefolium.jpg")
for(i in im[-1]){
  im1 <- image_join(im1, image_read(paste0("Example pictures/", i)))
}
im1 <- image_resize(im1, "x150")
im1
image_append(im1)
#image_morph(im1, frames = 10)

im1
attributes(im1)

