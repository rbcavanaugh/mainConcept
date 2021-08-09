#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  # reactiveValues is a list where elements of the list can change
  # startign places for pages and storing data. ####
  values = reactiveValues(i=0,
                          concept = list(),
                          selected_sentences = list(),
                          concept_accuracy = list()
  )
  values$previous <- NULL # previous data if uploaded
  values$num_previous <- 0 # number of previous tests
  values$datetime <- Sys.time() # establishes datetime when app opens for saving
  
  
  ################################## PREVIOUS DATA ###############################
  # ------------------------------------------------------------------------------
  ################################################################################ 
  
  # observer for uploading data
  observeEvent(input$file1,{
    file <- input$file1
    ext <- tools::file_ext(file$datapath)
    # check upload
    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))
    # save upload
    values$previous <- read.csv(file$datapath)
    
  })
  
  ################################## OBSERVERS ###################################
  # ------------------------------------------------------------------------------
  ################################################################################
  
  # disables the navbar buttons in different situations
  
  observe({
    if(values$i==0 || input$mainpage == "scoring"){
      shinyjs::disable(selector = "#mainpage li a[data-value=results]")
      shinyjs::disable(selector = "#mainpage li a[data-value=scoring]")
      shinyjs::enable(selector = "#mainpage li a[data-value=intro]")
    } else if(input$mainpage == "results"){
      shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
    } else if(input$mainpage == "intro" && values$i>0){
      shinyjs::enable(selector = "#mainpage li a[data-value=scoring]")
    } else {
      shinyjs::enable(selector = "#mainpage li a[data-value=intro]")
    }
    
  })
  
  ###########################Intro tab next and back############################
  observeEvent(input$glide_next1,{
    updateTabsetPanel(session, "glide", "glide2")
  })
  
  observeEvent(input$glide_back1,{
    updateTabsetPanel(session, "glide", "glide1")
  })
  
  observeEvent(input$glide_next2,{
    updateTabsetPanel(session, "glide", "glide3")
  })
  
  observeEvent(input$glide_back2,{
    updateTabsetPanel(session, "glide", "glide2")
  })
  
  observeEvent(input$glide_next3,{
    updateTabsetPanel(session, "glide", "glide4")
    values$norms = get_norms(stimulus = input$input_stimulus)
    print(head(values$norms))
  })
  
  observeEvent(input$glide_back3,{
    updateTabsetPanel(session, "glide", "glide3")
  })
  
  # buttons to advance scoring. dont delete you bozo. 
  
  observe(
    if(input$mainpage == "scoring"){
      shinyjs::show("footer_buttons")
    } else {
      shinyjs:: hide("footer_buttons")
    }
  )
  
  # can't hit previous on first page 
  
  observe(
    if(values$i == 1){
      shinyjs::disable("prev")
    } else {
      shinyjs::enable("prev")
    }
  )
  
  ################################## START ASSESSMENT ############################
  # start button. sets the i value to 1 corresponding to the first slide
  # switches to the assessment tab
  observeEvent(input$start, {
    
    values$i = 1
    values$stim_task <- tibble(
      stim = input$input_stimulus,
      stim_num = if(input$input_stimulus == 'broken_window'){1
      } else if(input$input_stimulus=='cat_rescue'){2
      } else if(input$input_stimulus == 'refused_umbrella'){3
      } else if(input$input_stimulus == 'cinderella'){4
      } else if(input$input_stimulus == 'sandwich'){5
      } else {0},
      num_slides = if(input$input_stimulus == 'broken_window'){8
      } else if(input$input_stimulus=='cat_rescue'){10
      } else if(input$input_stimulus == 'refused_umbrella'){10
      } else if(input$input_stimulus == 'cinderella'){34
      } else if(input$input_stimulus == 'sandwich'){10
      } else {0}
    )
    updateNavbarPage(session, "mainpage", selected = "scoring")
    values$transcript = input$input_transcript
    
  })
  
  #############################START OVER#########################################
  
  # if start over is hit, go to home page
  
  observeEvent(input$start_over,{
    # reset everything. not clear that this works...
    shinyjs::reset("intro_tab")
    # first intro glide
    updateTabsetPanel(session, "glide", "glide1")
    
    # immediately navigate back to previous tab
    updateTabsetPanel(session, "mainpage",
                      selected = "intro")
    # new date time for new run
    values$datetime <- Sys.time() # reestablishes datetime
    # i = zero before starting
    values$i=0
    # reset important data
    values$concept = list()
    values$selected_sentences = list()
    values$concept_accuracy = list()
    values$stim_task <- NULL
    
  })
  
  ########################## STORE RESPONSES #################################
  #counter fnctions to change page contents ######
  # note this also saves the input data to the reactive list 'values' #####
  
  # if next is hit
  # - store responses
  # iterate values$i which changes the concept which is displayed
  observeEvent(input$nxt,{
    
    # grab selected components
    score = c(input$accuracy1, input$accuracy2, input$accuracy3, input$accuracy4)
    len = length(score)
    
    # require them all to be scored. 
    if(len < values$concept_len){
      showNotification("Please score all components",  type = "error")
    } else {
      
      component = seq(1,len,1)
      concept = rep(values$i, len)
      
      # saving the data
      values$concept[[values$i]] = values$i
      values$selected_sentences[[values$i]] = input$score_mca
      values$concept_accuracy[[values$i]] = tibble(rating = score,
                                                   component = component,
                                                   concept = concept)
      # go to results if the scoring is done. 
      if (values$i == values$stim_task$num_slides) {
        updateNavbarPage(session, "mainpage", selected = "results")
      } else{
        # otherwise iterate values$i and move on to the next item. 
        values$i <- values$i + 1
      }
      
    }
    
    if(values$i==values$stim_task$num_slides){
      
      # if its the last concept, put all the results together. 
      values$results_mca <- 
        get_long_results_df(concept_accuracy = values$concept_accuracy,
                            filtered_concepts = 
                              values$concept_labels %>%
                              dplyr::select(id, e1:e4) %>%
                              pivot_longer(cols= e1:e4, names_to = "component", values_to = "element") %>%
                              mutate(component = as.numeric(str_remove(component, "e"))) %>%
                              rename(concept = id)
        )
      
    } 
    
    
    
  })
  
  # if you his previous, go back. prev is disabled on concept 1. 
  observeEvent(input$prev,{
    values$i <- values$i -1
  })
  
  
  ################################## FOOTER MODAL ################################
  # ------------------------------------------------------------------------------
  ################################################################################
  # More information modal
  observeEvent(input$info, {
    showModal(modalDialog(
      tags$iframe(src="https://docs.google.com/document/d/e/2PACX-1vR0_QBT5Ra5nDj5781RtlJcvSvEr8JJ9AwAJ9-xVbs_05c3khjw9Zj8__hA0CnrLQ/pub?embedded=true", width = "100%",
                  height = "650px", frameBorder = "0"),
      easyClose = TRUE,
      footer = NULL,
      size = "l"
    ))
  })
  # readme modal. probabily will be deleted
  observeEvent(input$about, {
    showModal(modalDialog(
      tags$iframe(src="https://aphasia-apps.github.io/mainconcept/", width = "100%",
                  height = "650px", frameBorder = "0"),
      # div(
      #     includeMarkdown(here("www", "bio.md"))
      # ),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  # dont delete this. uncomment it when you change the footer onclick
  observeEvent(input$references, {
    # showModal(modalDialog(
    #     div(
    #         includeMarkdown(here("www", "references.md"))
    #     ),
    #     size = "l",
    #     easyClose = TRUE,
    #     footer = NULL
    # ))
    
  })
  
  ################################### OTHER MODALS ############################
  #trascription rules
  observeEvent(input$full_transcription, {
    showModal(modalDialog(
      tags$iframe(src = "full_transcription.html", frameBorder="0",
                  height = "650px", width = "100%"),
      size = "l",
      easyClose = TRUE,
      footer = NULL
    ))
  })
  
  ################################## REACTIVE DATA ###############################
  # ------------------------------------------------------------------------------
  ################################################################################
  
  ################################## OUTPUTS #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  
  # this is the UI For the intro tab
  
  output$intro_div <- renderUI({
    get_intro_div()
  })
  
  # this is the UI For the scoring tab
  
  output$scoring_div <- renderUI({
    get_scoring_div(num=values$i)
  })
  
  # this is the UI For the results tab
  
  output$results_div <- renderUI({
    get_results_div()
  })

  
  ############################# Display Concept HTML CODE ####################
  # these are the concepts
  # gets fed to the scoring_div
  
  output$scoring_info <- renderUI({
    img_val = values$i
    paste_val = if(input$input_stimulus == 'broken_window'){'bw'
    } else if(input$input_stimulus == 'cat_rescue'){'cr'
    } else if(input$input_stimulus == 'refused_umbrella'){'u'
    } else if(input$input_stimulus == 'cinderella'){'c'
    } else if(input$input_stimulus == 'sandwich'){'s'
    } else {}
    if(img_val>0 && img_val < values$stim_task$num_slides+1){
      return(div(style = sty,
                 includeMarkdown(here("inst", "app", "www", input$input_stimulus, paste0(paste_val, img_val, ".md")))
                 )
      )
    } else {}
  })
  
  ############################### SELECT BUTTONS SENTENCES ###################
  # displays the unique sentences to be selected
  # get sentences #######
  output$sentence_buttons <- renderUI({
    df = tibble(txt = unlist(tokenize_sentences(input$input_transcript)))
    checkboxGroupButtons(
      inputId = "score_mca",
      justified = T, size = "sm",
      individual = T,
      choices = unique(df$txt),
      selected = if (length(values$selected_sentences)>=values$i && values$i>0){
        values$selected_sentences[[values$i]]
      } else {NULL},
    )
    
  })
  
  ######################### MAIN CONCEPT SCORING STUFF #######################
  
  # how long is the current concept?
  observeEvent(values$i,{
    req(values$i>0)
    values$concept_len <-
      main_concepts %>%
      dplyr::filter(task == input$input_stimulus) %>%
      ungroup() %>%
      #dplyr::select(concept_length) %>%
      slice(values$i) %>%
      pull(concept_length)
  })
  
  # holds label information for scoring buttons
  observeEvent(input$input_stimulus,{
    values$concept_labels <- 
      main_concepts %>%
      dplyr::filter(task == input$input_stimulus)
  })
  
  ########### These four setup the scoring buttons for concepts ##############
  ########### Score 1, 2, 3, 4 create the buttons ############################
  ########### score_sentences pulls them together to be rendered #############
  
  # change to NULL when ready for release. 
  test_var <-  "Absent" # NA
  
  # concept 1
  output$score1 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      radioGroupButtons(
        inputId = "accuracy1",
        label = values$concept_labels[values$i, 2], 
        choices = c("Accurate", "Inaccurate", "Absent"),
        direction = "vertical",
        selected = if (length(values$concept_accuracy)>values$i && values$i>0){
          values$concept_accuracy[[values$i]][1,1]
        } else {test_var}
      )
    } else {}
    
  })
  
  # concept 2
  output$score2 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      radioGroupButtons(
        inputId = "accuracy2",
        label = values$concept_labels[values$i, 3], 
        choices = c("Accurate", "Inaccurate", "Absent"),
        direction = "vertical",
        selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
          values$concept_accuracy[[values$i]][2,1]
        } else {test_var}
      )
    }else{}
    
  })
  
  # concept 3 - only shown when concept length is longer than 3
  output$score3 <- renderUI({
    if(values$i<values$stim_task$num_slides+1){
      if(values$concept_len<3){} else {
        radioGroupButtons(
          inputId = "accuracy3",
          label = values$concept_labels[values$i, 4], 
          choices = c("Accurate", "Inaccurate", "Absent"),
          direction = "vertical",
          selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
            values$concept_accuracy[[values$i]][3,1]
          } else {test_var}
        )
      } 
    }else{}
    
  })
  
  # concept 4 - only shown below for the one occurance. 
  output$score4 <- renderUI({
    radioGroupButtons(
      inputId = "accuracy4",
      label = values$concept_labels[values$i, 5], 
      choices = c("Accurate", "Inaccurate", "Absent"),
      direction = "vertical",
      selected = if (length(values$concept_accuracy)>=values$i && values$i>0){
        values$concept_accuracy[[values$i]][4,1]
      } else {test_var}
    )
  })
  
  # gathers the concept scoring buttons into a single UI to show. 
  output$score_sentences <- renderUI({
    if (input$input_stimulus == "cinderella" && values$i == 16){
      tagList(
        fluidRow(
          column(width = 3, align = "center",
                 uiOutput("score1")
          ),
          column(width = 3, align = "center",
                 uiOutput("score2")
          ),
          column(width = 3, align = "center",
                 uiOutput("score3")
          ),
          column(width = 3, align = "center",
                 uiOutput("score4")
          )
        )
      )
    } else {
      tagList(
        fluidRow(
          column(width = 4, align = "center", 
                 uiOutput("score1")
          ),
          column(width = 4, align = "center",
                 uiOutput("score2")
          ),
          column(width = 4, align = "center",
                 uiOutput("score3")
          )
        )
      )
    }
    
  })
  
  
  ################################## RESULTS #################################
  # --------------------------------------------------------------------------
  ############################################################################
  
  # which concepts are important for this stimulus?
  # filter_concepts <- reactive({
  #     main_concepts %>%
  #         ungroup() %>%
  #         dplyr::filter(task == input$input_stimulus) %>% 
  #         dplyr::select(id, e1:e4) %>%
  #         pivot_longer(cols= e1:e4, names_to = "component", values_to = "element") %>%
  #         mutate(component = as.numeric(str_remove(component, "e"))) %>%
  #         rename(concept = id)
  # })
  
  # gets the summary table of results. 
  results_mca_tab <- reactive({
    get_summary_table(results = values$results_mca, norms = values$norms)
    
  })
  
  # outputs text summary. 
  output$random_text <- renderText({
    shinipsum::random_text(nwords = 100)
  })
  
  # outputs summmary table 
  output$results_mca_table <- renderTable(
    results_mca_tab() %>%
      mutate(Points = as.character(Points)),
    align = "c", colnames = T
  )
  
  # outputs summary plot
  output$plot <- renderPlot({
    get_plot(values$norms,
             as.numeric(results_mca_tab()$Points[7]),
             input$input_stimulus)
  })
  
  
  ############## Downloads ##################################################3
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$stimMC, "_MC_summary.xlsx", sep = "")
    },
    content = function(file) {
      openxlsx::write.xlsx(list(
        transcript = tibble(
          transcript = values$transcript
        ),
        summary_scores = results_mca_tab(),
        by_concept = values$results_mca,
        by_component = bind_rows(values$concept_accuracy)
      )
      , file)
    }
  )
  
  
}
