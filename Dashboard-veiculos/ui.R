#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
dados <- read_csv("dados_shiny_2022081822.csv")


# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            selectInput(inputId = "idModelos", label = "Modelo: ",
                        choices = c(sort(unique(toupper(dados$MODELO))))),
            
            selectizeInput("iduf", "UF:", 
                           c(sort(unique(toupper(dados$UF)))),
                           options = list(maxItems = 4)
                           ),
            
            sliderInput("idAno",
                        "Ano do automovel:",
                        min = min(dados$ANO),
                        max = max(dados$ANO),
                        value = 2023, sep = ""),
            
            checkboxGroupInput("idOpcionais", "Opicionais",
                               choices = colnames(dados)[seq(27, 36)],
                               inline = T),
            
            actionButton("idExecuta" , "Consultar")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput(outputId = "teste"),
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
