#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    includeCSS(here("inst", "app", "www", "style.css")),
    shinyjs::useShinyjs(),
    waiter::useWaiter(),
    waiter::autoWaiter("waiter"),
    waiter::waiterPreloader(html=spin_dots(),color="white"),
      navbarPage(title = "Main Concept Analysis",
                 id = "mainpage",
                 footer = tags$div(
                   id = "footer_id",
                   class = "footer",
                   footer_div()
                 ),
                 
                 theme = minimal_theme(),
                 
                 ############################ Instructions ############################## 
                 tabPanel(value = "intro", title = "Intro", 
                         uiOutput("intro_div")
                 ),
                 ############################ Scoring ###################################
                 tabPanel(value = "scoring", title = "Scoring",
                          uiOutput("scoring_div")
                 ),
                 ############################ Results ###################################
                 tabPanel(value = "results", title = "Results", 
                          uiOutput("results_div")
                 ),#,
                 #tabPanel(value = "start_over", title = "Start Over")
                 ########################################################################
                 br(),br(),br(),br()     
      )
    )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'MCG'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

