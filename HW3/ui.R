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
ui <- fluidPage(# App title
  titlePanel("Gapminder Data"),
  # Sidebar layout with input and output definitions
  # Sidebar with a slider and select input for number of bins
  sidebarLayout(
    sidebarPanel(
      # choosing the years for the analysis
      sliderInput(
        "year",
        label = h3("Choose a year:"),
        min = 1990,
        max = 2009,
        value = 1996
      ),
      # Select a group of region for display
      checkboxGroupInput(
        "region_group",
        label = h3("Filter by region group:"),
        choices = unique(ff_data$four_regions),
        selected = "asia"
      ),
      hr(),
      # Add a horizontal rule
      checkboxInput("smooth", "Add smoother"),
      checkboxInput("facet", "Small multiples")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("distPlot"))
  ))
