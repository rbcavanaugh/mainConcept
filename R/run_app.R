#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts. 
#' See `?golem::get_golem_options` for more details.
#' @inheritParams shiny::shinyApp
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options 
#' @importFrom waiter autoWaiter useWaiter waiterPreloader spin_dots
#' @importFrom scales label_percent
#' @importFrom here here
#' @importFrom shinyjs useShinyjs hidden hide show enable disable
#' @importFrom bslib bs_theme font_google
#' @import dplyr
#' @importFrom tibble tibble
#' @importFrom readr read_csv
#' @import ggplot2
#' @import stringr
#' @importFrom tokenizers tokenize_sentences
#' @importFrom shinyWidgets checkboxGroupButtons radioGroupButtons
#' @import shinipsum
#' @import googlesheets4
#' @importFrom openxlsx write.xlsx
#' @import tidyr 
#' 
run_app <- function(
  onStart = NULL,
  options = list(), 
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  source("inst/global.R")
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options, 
      enableBookmarking = enableBookmarking, 
      uiPattern = uiPattern
    ), 
    golem_opts = list(...)
  )
}
