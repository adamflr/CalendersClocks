# Polygon examples
dat <- data.frame(x = c(1,2,3,1, 4,5,3,4), y = c(1,0,5,1, 2,4,6,2), id = rep(c("a", "b"), each = 4), 
                  im = "https://upload.wikimedia.org/wikipedia/commons/6/69/Kurre5.jpg")
ggplot(dat, aes(x, y, fill = id)) + geom_polygon(col = "black", alpha = 0.3)
