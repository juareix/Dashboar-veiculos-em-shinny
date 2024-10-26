#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)


# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            
            selectInput(inputId = "idModelos", label = "Modelo: ",
                        choices = c(sort(unique(dados$MODELO))))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            
            plotOutput("distPlot"),
            plotlyOutput(outputId = "grafico_media_valores"),
            plotlyOutput(outputId = "grafico_boxplot_preco"),
            plotlyOutput(outputId = "grafico_km_valor"),
            plotlyOutput(outputId = "grafico_tipo_anuncio"),
            plotlyOutput(outputId = "grafico_pie_cambio"),
            plotlyOutput(outputId = "grafico_pie_direcao"),
            plotlyOutput(outputId = "grafico_bar_cor"),
            
        )
    )
)
