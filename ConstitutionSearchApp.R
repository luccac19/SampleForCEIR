#load package
library(tidyverse)

#load data
constitutions<-read_csv("constitutions.csv")

#define keyword search function

conkw<-function(keyword,context,tribe=NA){
  if(is.na(tribe)){
    df<-data.frame(tribe=c(),searchresult=c())
    for (i in 1:length(constitutions$const.clean.text)){
      pattern <- paste0("((?:\\S+\\s+){0,", context, "})(\\S*\\b", keyword, "\\b\\S*)(?:\\s+(?:\\S+\\s+){0,", context, "})")
      searchresults<-unlist(str_extract_all(constitutions$const.clean.text[i],pattern))
      timestorep<-length(searchresults)
      df2<-data.frame(tribe=rep(constitutions$tribe[i],length.out=timestorep),searchresults=c(searchresults))
      df<-rbind(df,df2)
    }
    return(df)}else{
      df<-data.frame(tribe=c(),searchresult=c())
      pattern <- paste0("((?:\\S+\\s+){0,", context, "})(\\S*\\b", keyword, "\\b\\S*)(?:\\s+(?:\\S+\\s+){0,", context, "})")
      searchresults<-unlist(str_extract_all(constitutions$const.clean.text[constitutions$tribe==tribe],pattern))
      timestorep<-length(searchresults)
      df2<-data.frame(tribe=rep(tribe,length.out=timestorep),searchresults=c(searchresults))
      df<-rbind(df,df2)
      return(df)}
}
#define inputs
    library(shiny)
    ui <- fluidPage(
      titlePanel("Keyword Search in Constitutions"),
      
      sidebarLayout(
        sidebarPanel(
          textInput("keyword", "Enter Keyword:", ""),
          sliderInput("context", "Context (Words around the keyword in each direction):", 
                      min = 0, max = 100, value = 5),
          selectInput("tribe", "Select Tribe:", choices = c("All Tribes", unique(constitutions$tribe)), selected = "All Tribes")
        ),
        
        mainPanel(
          tableOutput("results")
        )
      )
    )
    
  
    server <- function(input, output) {
      
      search_results <- reactive({
        req(input$keyword)  
        keyword <- input$keyword
        context <- input$context
        tribe <- if(input$tribe == "All Tribes") NA else input$tribe
        
        # Call function with inputs
        conkw(keyword, context, tribe)
      })
      
      #produce table of search results
      output$results <- renderTable({
        results <- search_results()
        if (nrow(results) > 0) {
          return(results)
        } else {
          return(data.frame(message = "No results found"))
        }
      })
    }
    
    # Run the application
    shinyApp(ui = ui, server = server)
    