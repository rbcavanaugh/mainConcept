# long results table

get_long_results_df <- function(concept_accuracy, filtered_concepts){
  df <- 
    bind_rows(concept_accuracy) %>%
    left_join(filtered_concepts, by = c('concept', 'component')) %>%
    drop_na(element) %>%
    group_by(concept) %>%
    summarize(absent = sum(as.numeric(rating == "Absent")),
              accurate = sum(as.numeric(rating == "Accurate")),
              inaccurate = sum(as.numeric(rating == "Inaccurate"))) %>%
    mutate(
      accuracy = case_when(
        inaccurate > 0 ~ "I",
        accurate > 0 ~ "A",
        TRUE ~ "Absent"
      ),
      completeness = case_when(
        absent > 0 ~ "I",
        absent == 0 ~ "C",
        TRUE ~ "missed"
      )
    ) %>%
    mutate(completeness = ifelse(accuracy == "Absent", "", completeness)) %>%
    unite(col = "Result", accuracy, completeness, sep = "", remove = F) %>%
    left_join(scoring_mca, by = "Result")
  
  return(df)
}