#' ecdf_function 
#'
#' @description returns percentile from norm data
#'
#' @return A formatted percentile
#'
#' @noRd
ecdf_fun <- function(x,perc) scales::label_percent()(ecdf(x)(perc))
