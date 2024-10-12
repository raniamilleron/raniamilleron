library(shiny)
library(lubridate)

# Read the data
data <- read.csv(url("https://data.cdc.gov/resource/jr58-6ysp.csv?variant=BA.2.86"))

# Extract only the date part from 'week_ending' and convert to Date format
data$week_ending <- as.Date(substr(data$week_ending, 1, 10), format = "%Y-%m-%d")

# Define the UI
ui <- fluidPage(
  titlePanel("BA.2.86 SARS-CoV-2 Variants by HHS Region"),
  sidebarLayout(
    sidebarPanel(
      textInput("usa_or_hhsregion", "Enter your HHS Region:"),
      textInput("week_ending", "Enter Biweekly Date YYYY-MM-DD (e.g., 2023-10-28):")
    ),
    mainPanel(
      tags$img(src = "https://www.hhs.gov/sites/default/files/regional-offices.png", height = 200, width = 300),
      tableOutput("variant_table")
    )
  )
)

server <- function(input, output) {
  selected_variants <- reactive({
    req(input$usa_or_hhsregion, input$week_ending)
    # Convert the input$week_ending to Date format
    input_date <- as.Date(input$week_ending, format = "%Y-%m-%d")
    
    # Filter the data based on the user input
    filtered_data <- subset(data,
                            usa_or_hhsregion == as.character(input$usa_or_hhsregion) & 
                              week_ending == input_date)
    
    print(filtered_data)  # Print the filtered data to console for debugging
    return(filtered_data)
  })
  
  output$variant_table <- renderTable({
    variants <- selected_variants()
    if (nrow(variants) == 0) {
      return(data.frame(Message = "No data available for the selected inputs."))
    } else {
      return(variants)
    }
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)

  
  output$variant_table <- renderTable({
    variants <- selected_variants()
    if (nrow(variants) == 0) {
      return(data.frame(Message = "No data available for the selected inputs."))
    } else {
      return(variants)
    }
  })



# Run the Shiny app
shinyApp(ui = ui, server = server)
