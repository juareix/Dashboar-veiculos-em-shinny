#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')

    })
    
    output$grafico_media_valores <- renderPlotly({
      
      mediana_data <- dados_select %>%
        group_by(DATA_COLETA_METADADOS, UF) %>%
        summarise(mediaValor = median(VALOR))
      
      ggplotly(
        mediana_data %>%
          ggplot() + 
          geom_line(aes(x = DATA_COLETA_METADADOS, y = mediaValor,
                        group = UF, color = UF), size = 1) + ggtitle("Média Valor") +
          scale_color_brewer(palette = "Dark2")
      )
    })
    
    output$grafico_boxplot_preco <- renderPlotly({
      ggplotly(
        dados_select %>%
          ggplot() + 
          geom_boxplot(aes(x = UF, y = VALOR, fill = UF)) +
          ggtitle('Variação de preço por UF') +
          theme(legend.position = "none") +
          scale_fill_brewer(palette = "Dark2")
      )
    })
    
    output$grafico_km_valor <- renderPlotly({
      ggplotly(
        dados_select %>%
          ggplot() + 
          geom_point(aes(x = QUILOMETRAGEM, y = VALOR, color = UF)) +
          ggtitle("Distribuição do VALOR e KM por UF") +
          scale_color_brewer(palette = "Dark2")
      )
    })
    
    output$grafico_tipo_anuncio <- renderPlotly({
      ggplotly(
        dados_select %>%
          ggplot() + 
          geom_boxplot(aes(x = TIPO_ANUNCIO, y = VALOR, fill = UF)) +
          ggtitle('Variação de preço por UF') +
          scale_fill_brewer(palette = "Dark2")
      ) %>% layout(boxmode = "group")
    })
    
    output$grafico_pie_cambio <- renderPlotly({
      freq_cambio <- dados_select %>%
        group_by(CÂMBIO) %>%
        summarise(qtd = n()) %>%
        mutate(prop = qtd / sum(qtd) * 100) %>%
        mutate(ypos = cumsum(prop) - 0.5 * prop)
      
      
      plot_ly(freq_cambio, labels = ~CÂMBIO, values = ~prop,
              type = 'pie', textinfo = "label+percent",
              showlegend = FALSE) %>%
        layout(title = 'Quantidade por Câmbio')
    })
    
    output$grafico_pie_direcao <- renderPlotly({
      freq_direcao <- dados_select %>%
        group_by(DIREÇÃO) %>%
        summarise(qtd = n()) %>%
        mutate(prop = qtd / sum(qtd) * 100) %>%
        mutate(ypos = cumsum(prop) - 0.5 * prop)
      
      plot_ly(freq_direcao, labels = ~DIREÇÃO, values = ~prop,
              type = 'pie', textinfo = "label+percent",
              showlegend = FALSE) %>%
        layout(title = 'Quantidade por Direção')
    })
    
    output$grafico_bar_cor <- renderPlotly({
      ggplotly(
        dados_select %>%
          group_by(COR) %>%
          summarise(QTD = n()) %>%
          ggplot() + 
          geom_bar(aes(x = reorder(COR, QTD), y = QTD, fill = QTD,
                       text = paste("COR:", COR, "\n",
                                    "QTD:", QTD)
          ), stat = 'identity') +
          xlab('COR') + ggtitle('Quantidade por Cor') +
          theme(legend.position = 'none'), 
        
        tooltip = c("text")
        
      )
    })

}
