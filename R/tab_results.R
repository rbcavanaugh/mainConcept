##### results tab

get_results_div <- function(){
  tagList(
    div(id="waiter",
      column(width = 10, offset = 1,
        fluidRow(
                    h4("This will be information about interpreting results"),
                    textOutput("random_text"),
          ),
        fluidRow(
          column(width = 5, align = "center",
                 br(),
                 tableOutput("results_mca_table"),
          ),
          column(width = 7,
                 div(align = "center",
                  br(),
                  plotOutput("plot", height = "300")
                 )
          )
        ),br(),
        fluidRow(
          column(align = "center", width = 10, offset = 1,
                    downloadButton("downloadData", "Download Data"),
                 actionButton("start_over", "Start Over", icon = icon("undo"))
          )
        )
      )
    )
  )
}