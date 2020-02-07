library(magick)

pic1 <- image_read("Example pictures/Achillea millefolium.jpg")
image_scale(pic1, "1000x1000")
pic_base <- image_blank(250, 250)
pic_base
