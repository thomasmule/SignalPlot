#' ---
#' title: "Initial Functions and Libraries"
#' author: "Kevin Lu"
#' output: 
#'   html_document: 
#'     toc: true 
#'     toc_float: true
#'     number_sections: false
#' ---

#' # 1. Load Packages
library(Quandl)
library(tidyverse)
library(lubridate)
library(quantmod)
library(RcppRoll)

#' # 2. Quandl Functions 
#' Please don't use my key. The quandl_tidy function is a wrapper around the Quandl function 
#' that returns a cleaner tibble.  
Quandl.api_key("EbaoLxynTBPZx9bjNAwC")

#' # 3. ggplot2 Theme
theme_alphaplot <- function(base_size = 11, base_family = "") {
  half_line <- base_size / 2
  theme(line = element_line(colour = "black", size = 0.5, linetype = 1, lineend = "butt"), 
        rect = element_rect(fill = "white", colour = "black", size = 0.5, linetype = 1), 
        text = element_text(family = base_family, face = "plain", colour = "black", size = base_size, 
                            lineheight = 0.9, hjust = 0.5, vjust = 0.5, angle = 0, margin = margin(), 
                            debug = FALSE), 
        axis.line = element_blank(), 
        axis.text = element_text(face = "bold", colour = "#535353"), 
        axis.text.x = element_text(margin = margin(t = 0.8 * half_line / 2), vjust = 1), 
        axis.text.y = element_text(margin = margin(r = 0.8 * half_line / 2), hjust = 1), 
        axis.ticks =  element_blank(), 
        axis.ticks.length =  unit(half_line / 2, "pt"), 
        axis.title.x =  element_text(face = "bold", colour = "#535353", 
                                     margin = margin(t = 0.8 * half_line, b = 0.8 * half_line / 2)), 
        axis.title.y = element_text(face = "bold", colour = "#535353", angle = 90, 
                                    margin = margin(r = 0.8 * half_line, l = 0.8 * half_line / 2)), 
        legend.background = element_rect(fill = "#F0F0F0", colour = NA), 
        legend.spacing = unit(0.2, "cm"), 
        legend.key = element_rect(fill = "#F0F0F0", colour = "#F0F0F0"), 
        legend.key.size = unit(1.2, "lines"), 
        legend.key.height = NULL, 
        legend.key.width = NULL, 
        legend.text = element_text(size = rel(0.8)), 
        legend.text.align = NULL, 
        legend.title = element_text(hjust = 0), 
        legend.title.align = NULL, 
        legend.position = "right", 
        legend.direction =  NULL, 
        legend.justification = "center", 
        legend.box = NULL, 
        panel.background = element_rect(fill = "#F0F0F0", colour = NA), 
        panel.border = element_rect(fill = NA, colour = "#F0F0F0"), 
        panel.grid.major = element_line(colour = "#D0D0D0", size = 0.60), 
        panel.grid.minor = element_line(colour = "#D0D0D0", size = 0.60), 
        panel.spacing = unit(half_line, "pt"), 
        panel.ontop = FALSE, 
        strip.background = element_rect(fill = "grey85", colour = NA), 
        strip.text = element_text(colour = "grey10", size = rel(0.8)), 
        strip.text.x = element_text(margin = margin(t = half_line, b = half_line)), 
        strip.text.y = element_text(angle = -90, margin = margin(l = half_line, r = half_line)), 
        strip.switch.pad.grid = unit(0.1, "cm"), 
        strip.switch.pad.wrap = unit(0.1, "cm"), 
        plot.background = element_rect(fill = "#F0F0F0", colour = NA), 
        plot.title = element_text(face = "bold", hjust = 0, vjust = 2, colour = "#3C3C3C", size = rel(1.5), 
                                  margin = margin(b = half_line * 1.2)), 
        plot.margin = margin(half_line, half_line * 3, half_line, half_line), 
        complete = TRUE
  )
}

#' # 4. Get Yahoo Data
getSymbolsYahoo <- function(ticker) {
  df <- quantmod::getSymbols(ticker, src = "yahoo", auto.assign = FALSE, from = "1900-01-01")
  df <- df %>% 
    as_tibble() %>% 
    mutate(date = index(df), 
           ticker = ticker)
  colnames(df) <- c("open", "high", "low", "close", "volume", "adjusted_close", "date", "ticker")
  return(df)
}
