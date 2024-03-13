#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Prepare the server -----------------------------------------------------
function(input, output) {
  # Filter the data based on the user input
  subset_data <- reactive({
    req(input$region_group)
    ff_data %>%
      filter(four_regions %in% input$region_group) %>%
      filter(Year == input$year)
  })
    # Create the plot
  output$distPlot <- renderPlot({
    p <- ggplot(
      subset_data(),
      aes(
        x = `GDP per cap`,
        y = `Paved Roads`,
        label = country,
        color = four_regions
      )
    ) +
      list(
        geom_point(
          aes(color = four_regions),
          alpha = 0.55,
          size = 3
        ),
        if (input$smooth) {
          geom_smooth(method = "lm",
                      se = TRUE)
        },
        if (input$smooth) {
          stat_cor(
            aes(label = paste(..rr.label.., ..p.label.., sep = "~`,`~")),
            label.x = 0.5,
            label.y = 0.999,
            size = 3
          )
        }
        ,
        geom_text_repel(
          size = 2.5,
          alpha = 0.60,
          segment.size = 0.2
        ),
        scale_color_brewer(palette = "Set1"),
        labs(
          title = "GDP per Capita vs Paved Roads",
          x = "GDP per Capita",
          y = "Paved Roads",
          color = "Region"
        ),
        scale_x_continuous(labels = scales::dollar),
        scale_y_continuous(labels = scales::percent),
        if (input$facet)
          facet_wrap(~ four_regions)
      )
    p
  }, height = 600, width = 900)
}

# Here is the end ---------------------------------------------------------
