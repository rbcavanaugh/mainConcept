
# score = results_mca_tab$Points[7]
# norms = values$norms
# stim = input$input_stimulus
#' @export
get_plot <- function(norms, current_score, stim){
  
  val = subset(mc_reference, name == stim)$num 
  max_val = val*3
  
  dat = norms %>%
    mutate(group = ifelse(Aphasia == 1, "Aphasia", "Control")) %>%
    rename(score = `MC COMPOSITE`)

  p = dat %>%
    ggplot(aes(x=score, fill = group, group = group)) +
    geom_density(alpha = .3) +
    theme_minimal(base_size = 14) +
    geom_vline(aes(xintercept = current_score), color = "darkred", linetype = "dashed") +
    scale_x_continuous(limits = c(0,max_val), breaks = seq(0,max_val, 2)) +
    theme(axis.text.y=element_blank(),
          axis.ticks.y = element_blank()) +
    labs(y=NULL, x="Composite Score")
  
  return(p)

}


