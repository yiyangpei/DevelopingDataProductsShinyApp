# if (!require("DT")) devtools::install_github("rstudio/DT")
library(DT)
GES <- read.csv("data/GES.csv")
# GES <- GES[,c(1,3:5,7:10)]
# names(GES) <- c("University","Degree.Category","Degree.Name","Employment.Rate","Basic.Mean","Basic.Median","Gross.Mean","Gross.Median")
col <- c("University","Degree.Category","Degree.Name","Employment.Rate")

library(ggplot2)

shinyServer(
    function(input, output) {
            col_sel <- reactive({ paste(input$salary.type, input$statistics, sep=".") })
            row_sel <- reactive({ GES$University %in% input$university & GES$Degree.Category %in% input$category })
            GES_sel <- reactive({ GES[ row_sel() , c(col, col_sel())] })
       
            output$table <- renderDataTable(GES_sel(), options = list(paging = FALSE))  
            output$noData <- renderText({
                 if (length(input$university)==0 & length(input$category)==0)
                 {
                     print("Please select university and degree category.")
                 }
                 else if (length(input$university)==0)
                 {
                     print("Please select university.")
                 }
                 else if (length(input$category)==0)
                 {
                     print("Please select degree category.")
                 }                 
                 else if (dim(GES_sel())[1]==0)
                 {
                    print("No data is available for your selection.")
                 }    
#                  else
#                  {}
            })
            output$plot.er <- renderPlot({
                if (dim(GES_sel())[1])
                {
                    print(ggplot(data=GES_sel(), aes_string(x= "Degree.Name", y="Employment.Rate",fill="University")) +
                        facet_grid(. ~ Degree.Category,scales="free", space="free") +
                        geom_bar(stat="identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0)) + xlab("Degree.Name")  +
                        ggtitle("Employment Rate") )
                    
                }                 
            })
            output$plot.salary <- renderPlot({
                if (dim(GES_sel())[1])
                {
                    print(ggplot(data=GES_sel(), aes_string(x= "Degree.Name", y=col_sel(),fill="University")) +
                        facet_grid(. ~ Degree.Category,scales="free", space="free") +
                        geom_bar(stat="identity") +
                        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0)) + xlab("Degree.Name")  +
                        ggtitle(paste(input$statistics,  input$salary.type, "Monthly Salary", sep=" ")) )
                }                 
            })
        
    }
)

# reorder(Degree.Name,-paste(input$salary.type, input$statistics, sep="."))

