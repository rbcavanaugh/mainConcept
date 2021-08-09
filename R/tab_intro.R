
get_intro_div <- function(){
   column(width = 12,
          tabsetPanel(type="hidden",
                      id = "glide",
                      tabPanelBody(value = "glide1",
                                   column(width = 10, offset = 1,
                                          div(
                                            includeMarkdown(here("inst", "app", "www", "intro.md"))
                                            #markdown(intro_md)
                                          ),
                                          div(align="center",
                                              actionButton("glide_next1", "Next"))
                                   )
                                   
                      ),
                      tabPanelBody(value = "glide2",
                                   column(width = 10, offset = 1,
                                          div(class="ox-hugo-table basic-styling",
                                            #markdown(scoring_md)
                                            includeMarkdown(here("inst", "app", "www", "scoring.md"))
                                          ),
                                          div(align="center",
                                              actionButton("glide_back1", "Back"),
                                              actionButton("glide_next2", "Get Started"))
                                   )
                                   
                      ),
                      tabPanelBody(value = "glide3",
                                   column(width = 10, offset = 1,
                                    div(align = "center",
                                       div(style="display: inline-block; text-align: left;",
                                           h5("Input participant information"), br(),
                                           textInput("name", "Enter a Name"),
                                           selectInput(inputId = "input_stimulus",
                                                        label = "Select stimulus",
                                                        c("Broken Window" = 'broken_window',
                                                          "Cat Rescue" = 'cat_rescue',
                                                          "Refused Umbrella" = 'refused_umbrella',
                                                          "Cinderella" = 'cinderella',
                                                          "Sandwich" = 'sandwich'),
                                                        selected = "broken_window"#, 
                                                        #inline = F
                                                       ),
                                           numericInput("input_duration",
                                                        "Enter Duration (seconds)",
                                                        value = 0,
                                                        min = 0,
                                                        max = 720
                                           ),
                                           textAreaInput("notes", "Enter any notes", width = "100%", height = "100px"),
                                           #fileInput("file1", "Upload previous results", accept = ".csv"),
                                       )
                                   ),
                                   div(align = "center",
                                       actionButton("glide_back2", "Back"),
                                       actionButton("glide_next3", "Next")
                                   )
                                  )
                      ),
                      tabPanelBody(value = "glide4",
                                fluidRow(
                                   column(width = 5, offset = 1, 
                                     tabsetPanel(id ="instructions",
                                                 tabPanel("Transcribing", br(),
                                                          div(style="height:500px; overflow:auto;",
                                                            includeMarkdown(here("inst", "app", "www", "transcribing.md"))
                                                          )
                                                 ),
                                                 tabPanel("Segmenting", br(),
                                                          includeMarkdown(here("inst", "app", "www",  "segmenting.md"))
                                                          )
                                             #)
                                           #)
                                       )
                                   ),
                                   column(width = 5,
                                           textAreaInput("input_transcript",
                                                         "Enter transcript (separate utterances with a period)",
                                                         height = "400px",
                                                         width = "100%",
                                                         value = transcriptDefault
                                           ),
                                          actionButton("full_transcription",
                                                       "Detailed transcription rules")
                                        )
                                      ),
                                br(),
                                fluidRow(
                                  column(width = 10, offset = 1,
                                       div(align = "center",
                                               actionButton("glide_back3", "Back"),
                                               actionButton("start",
                                                            "Begin Scoring")
                                           )
                                       )
                                )
                                   )
                      )
   )
}



