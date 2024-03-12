#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/



# Prepare the app ---------------------------------------------------------
source("Data_Wrangling.R")
library(shiny)


# Define the UI -----------------------------------------------------------
ui <- fluidPage(
  titlePanel("Gapminder Data"),
  sidebarLayout(
    sidebarPanel(
      selectInput("x", "X-axis:", choices = c("GDP per cap", "Paved Roads")),
      selectInput("y", "Y-axis:", choices = c("GDP per cap", "Paved Roads")),
      selectInput("color", "Color:", choices = c("GDP per cap", "Paved Roads")),
      selectInput("size", "Size:", choices = c("GDP per cap", "Paved Roads"))
    ),
    mainPanel(
      plotOutput("scatterplot")
    )
  )
)

