library(DT)

shinyUI(
        fluidPage(
                titlePanel("Singapore Graduate Employment Survey 2014"),
                p("* The Graduate Employment Survey (GES) is jointly conducted by three universities in Singapore (NTU, NUS and SMU) annually to survey the employment conditions of graduates as at 1 Nov, about six months after their final examinations.  The results of the survey is intended to assit the prospective students in making informed course decisions. In GES 2014, 13,656 graduates from NTU, NUS and SMU were surveyed and the overall response rate obtained was 74%. "),
                p("* The data used to build the application was retrieved from data.gov.sg ."),
                br(),
                sidebarLayout(
                        sidebarPanel( 
                                helpText("Please press the submit button after making or changing your selection."),
                                checkboxGroupInput("university", label="University:", 
                                            choices = c("NTU", "NUS", "SMU")),
                                checkboxGroupInput("category", label="Degree Category:", 
                                             choices = c("Arts & Social Sciences","Business", "Engineering", "Law","Medicine","Science")),
                                selectInput("salary.type", label="Basic or Gross Monthly Salary:", 
                                                    choices = c("Basic", "Gross")),
                                selectInput("statistics", label="Statistics of Monthly Salary:", 
                                                    choices = c("Mean", "Median")),
                                submitButton(text = "Submit", icon=NULL)
#                                         actionButton("submit", "Submit")
                                       
                                        
                                ),
                        mainPanel(
                                tabsetPanel(type = "tabs", 
                                        tabPanel("View by Plot", 
                                                 br(),
                                                 textOutput("noData"),
                                                 plotOutput("plot.er",height = 600),
                                                 plotOutput("plot.salary",height = 600)
                                                ), 
                                        tabPanel("View by Table", dataTableOutput("table"))
                                        )
                                )
                        
                        )
        )

)

