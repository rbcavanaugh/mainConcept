
get_norms <- function(stimulus){

  # links to google sheets for norms:
  refused_umbrella = "1oYiwnUdO0dOsFVTmdZBCxkAQc5Ui-71GhUSchK_YY44"
  broken_window = "12SAkAG8VCAkhCFv4ceJiqgRZ7U9-P9bEcet--hDeW2s"
  cinderella = "1fpDq7aTrKVkfjdv8ka7BS5_iHEJ8HHI-q9nJI6wDAEA"
  sandwich = "1o29bBQbyNlmtL05kkTuLV6z5auz1msDeLSxIO1p_3EA"
  cat_rescue = "1sTvSX0Ws0kPTw-5HHyY8JO2CubqWVgEzDvE5BuGSefc"

  # go into deauth mode
  gs4_deauth()
  
  norms <- tryCatch(
          read_sheet(ss = get(stimulus)),
          error = function(e) "Unable to connect; using norms updated 8/1/21"
        )

  if(is.character(norms)){
    return(static_norms)
  } else {
    return(norms)
  }

}




update_static_norms <- function() {
  
  refused_umbrella = get_norms("refused_umbrella")
  cat_rescue = get_norms("cat_rescue")
  cinderella = get_norms("cinderella")
  sandwich = get_norms("sandwich")
  broken_window = get_norms("broken_window")
  
  static_norms <- bind_rows(lst(refused_umbrella, cat_rescue, cinderella, sandwich, broken_window), .id = "stimulus")
  
  use_data(static_norms)
  
}
