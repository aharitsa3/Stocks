library(tidyquant)
library(dplyr)
library(ggplot2)
library(xts)


for (stock in c('AAPL','MSFT','SBUX','GOOG')){
  getSymbols(stock,from='2016-01-01',to='2020-04-01')
}

# ggplot(data=MSFT,aes(index(MSFT),MSFT.Adjusted)) +
#   geom_line() +
#   geom_line(data = AAPL, aes(index(AAPL),AAPL.Adjusted,col='red')) +
#   geom_line(data = SBUX, aes(index(SBUX),SBUX.Adjusted,col='green'))


