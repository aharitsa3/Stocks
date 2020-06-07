library(dplyr)
library(BatchGetSymbols)
library(ggplot2)

# set dates
first.date <- Sys.Date() - (365*5)
last.date <- Sys.Date()
freq.data <- 'daily'
# set tickers
tickers <- c('AAPL')

l.out <- BatchGetSymbols(tickers = tickers, 
                         first.date = first.date,
                         last.date = last.date, 
                         freq.data = freq.data,
                         cache.folder = file.path(tempdir(), 
                                                  'BGS_Cache') ) # cache in tempdir()

# practice plotting the historical apple prices
# p <- ggplot(l.out$df.tickers, aes(x=ref.date,y=price.close)) + 
#   geom_line() +
#   facet_wrap(~ticker, scales='free_y')

# p



