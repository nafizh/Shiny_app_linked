library(ggvis)
library(dplyr)

mtcars$id <- seq_len(nrow(mtcars))

shinyServer(function(input, output, session) {
   
  lb <- linked_brush(keys = mtcars$id, "red")

mtcars %>%
  ggvis(~mpg, ~wt) %>%
  layer_points(fill := lb$fill, fill.brush := "red") %>%
  lb$input() %>%
  set_options(width = 300, height = 300) %>%
  #the next line will add red points that have the same gear as the ones selected
  layer_points(fill := "red", data = reactive(mtcars[mtcars$gear %in% mtcars[lb$selected(),]$gear,])) %>%
  bind_shiny("plot1") 
  
})