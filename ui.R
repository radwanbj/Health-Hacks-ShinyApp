library(shiny)
library(shinydashboard)

body_about <- dashboardBody(
  fluidRow(
    fluidRow(
      #column(
        box(
          img (src = "slide2.png"),br(),br(), img(src ="slide1.png"),
          title = div("User Guide", style = "padding-left: 40px", class = "h2"),
          width = 12,
        ),
      #  width = 12,
      #  style = "padding: 30px"
      #)
    )
  )
)


page_about <- dashboardPage(
  title = "About",
  header = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body = body_about
)

# Home
body_home <- dashboardBody(
  titlePanel(img(src = "logo.png", height = 140, width = 400)),
    sidebarLayout(
      sidebarPanel(selectInput(inputId = "sex",
                               label = "Gender",
                               choices = c("Male" = "m",
                                           "Female" = "f")),
                   numericInput(inputId = "age",
                                label = "Age", 
                                value = ""),
                   numericInput(inputId = "weight",
                                label = "Weight(kg)", 
                                value = ""),
                   numericInput(inputId = "height",
                                label = "Height(cm)", 
                                value = ""),
                   numericInput(inputId = "activity",
                                label = "Minutes of exercise daily(min)", 
                                value = ""),
                   actionButton("calculatebutton", 
                                "Calculate", 
                                class = "btn btn-primary"),
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("BMI", textOutput("Bdisplay"), textOutput("Bmeans"), textOutput("IdealW")),
          tabPanel("Body Fat", textOutput("fatDisp")),
          tabPanel("Body Calories", textOutput("calories"),textOutput("CalorieExplain")),
          tabPanel("Body Water", textOutput("water")),
          tabPanel("Daily Water Intakes", textOutput("intake"))
        )
      )
    ), 
  
)



page_home <- dashboardPage(
  title   = "Home",
  header  = dashboardHeader(disable = TRUE),
  sidebar = dashboardSidebar(disable = TRUE),
  body    = body_home
)

ui <- fluidPage(
  title = "Health Hacks",
  navbarPage(
    title       = div("Health Hacks", style = "padding-left: 10px"),
    inverse = TRUE,
    collapsible = TRUE,
    fluid       = TRUE,
    tabPanel("Home", page_home, value = "page-home"),
    tabPanel("User Guide", page_about, value = "page-about")
  )
)