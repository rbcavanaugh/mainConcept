minimal_theme <- function(){
  theme = bs_theme(bootswatch = "default",
         base_font = font_google("Open Sans"),
         heading_font = font_google("Open Sans"),
         version = "4",
         `enable-rounded` = T,
         `enable-transitions` = F,
         primary = "#1665AC",
         "navbar-bg" = "#dee2e6"
  )
  return(theme)
}