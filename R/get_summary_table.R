### gets table of results for summary 

get_summary_table <- function(results, norms){
  df = results %>%
    select(Concept = concept, Code = Result, Score = score) %>%
    summarize(`AC` = sum(Code == 'AC'),
              `AI` = sum(Code == 'AI'),
              `IC` = sum(Code == 'IC'),
              `II` = sum(Code == 'II'),
              Absent = sum(Code == 'Absent'),
              `Attempts` = sum(Code == 'AC'|Code == 'AI'|Code == 'IC'| Code == 
                                 'II'),
              `Composite` = sum(Score)
    ) %>% 
    pivot_longer(cols = everything(), names_to = 'Variable', values_to = 'Count') %>%
    mutate(Count = as.character(Count))
  
  df$Points = NA
  df[[1,3]] = round(as.numeric(df[1,2])*3)
  df[[2,3]] = round(as.numeric(df[2,2])*2)
  df[[3,3]] = round(as.numeric(df[3,2])*2)
  df[[4,3]] = round(as.numeric(df[4,2])*1)
  df[[5,3]] = round(as.numeric(df[6,2])*0)
  #df[[6,3]] = NA
  df[[7,3]] = round(as.numeric(df[7,2]))
  df[[7,2]] = NA
  
  df$`Percentile (Aphasia)` = NA
  df[[1,4]] = ecdf_fun(subset(norms, Aphasia==1)$AC, as.numeric(df[1,2]))
  df[[2,4]] = ecdf_fun(subset(norms, Aphasia==1)$AI, as.numeric(df[2,2]))
  df[[3,4]] = ecdf_fun(subset(norms, Aphasia==1)$IC, as.numeric(df[3,2]))
  df[[4,4]] = ecdf_fun(subset(norms, Aphasia==1)$II, as.numeric(df[4,2]))
  df[[5,4]] = ecdf_fun(subset(norms, Aphasia==1)$AB, as.numeric(df[5,2]))
  df[[6,4]] = ecdf_fun(subset(norms, Aphasia==1)$`MC Attempts`, as.numeric(df[6,2]))
  df[[7,4]] = ecdf_fun(subset(norms, Aphasia==1)$`MC COMPOSITE`, as.numeric(df[7,3]))
  
  df$`Percentile (Control)` = NA
  df[[1,5]] = ecdf_fun(subset(norms, Aphasia==0)$AC, as.numeric(df[1,2]))
  df[[2,5]] = ecdf_fun(subset(norms, Aphasia==0)$AI, as.numeric(df[2,2]))
  df[[3,5]] = ecdf_fun(subset(norms, Aphasia==0)$IC, as.numeric(df[3,2]))
  df[[4,5]] = ecdf_fun(subset(norms, Aphasia==0)$II, as.numeric(df[4,2]))
  df[[5,5]] = ecdf_fun(subset(norms, Aphasia==0)$AB, as.numeric(df[5,2]))
  df[[6,5]] = ecdf_fun(subset(norms, Aphasia==0)$`MC Attempts`, as.numeric(df[6,2]))
  df[[7,5]] = ecdf_fun(subset(norms, Aphasia==0)$`MC COMPOSITE`, as.numeric(df[7,3]))

  return(df)
}