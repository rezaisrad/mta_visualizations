## ui.R ##
library(shinydashboard)

shinyUI(
  dashboardPage(
  dashboardHeader(title = "NYC MTA Visualization"),
  dashboardSidebar(
    sidebarUserPanel("Reza Rad",
                   image = "http://nycdsdev.staging.wpengine.com/wp-content/themes/nycdsa/images/au_02.png"),
    sidebarMenu(
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Fares Data", tabName = "fares", icon = icon("database")),
      menuItem("Turnstile Data", tabName = "turnstile", icon = icon("database")))
    
   
    # dateInput(inputId = "date",
    #           label = "Date",
    #           value = "2016-01-01",
    #           min = "2016-01-01",
    #           max = "2017-01-01")
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "map",
              fluidRow(box(htmlOutput("map"), 
                           height = 300))
              ),
      tabItem(tabName = "fares",
              fluidRow(box(dataTableOutput("fares_data"),
                           width = 12))
              ),
      tabItem(tabName = "turnstile",
              fluidRow(box(dataTableOutput("turnstile_data"),
                           width = 12))
              )
      )
  )
))