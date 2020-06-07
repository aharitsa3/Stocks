library(dplyr)
library(BatchGetSymbols)
library(ggplot2)
library(forecast)
library(tseries)
library(summarytools)
library(MASS)
library(rcompanion)


# set dates
first.date <- Sys.Date() - (365*8)
last.date <- Sys.Date()
freq.data <- 'weekly'
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




# transform data into timeseries object

tsdata <- ts(l.out$df.tickers$price.close,frequency=52)


cycle(tsdata)


plot.ts(tsdata)


logts <- (tsdata)**(1/3)
plot.ts(logts)





Box <- boxcox(tsdata ~ 1, lambda = seq(-6,6,0.1))

cox <- data.frame(Box$x,Box$y)
Cox2 <- cox[with(cox, order(-cox$Box.y)),]


lambda <- Cox2[1,"Box.x"]

ts_tranform <- (tsdata ^ lambda - 1)/lambda
plot.ts(ts_tranform)
plotNormalHistogram(ts_tranform)

acf(tsdata)







# steps for time series analysis of stocks:
# 1. find moving average, exponential smoothing and double exponential smoothing plots
# 2. find if data is stationary by applying Dickey-Fuller test
# 3. if not stationary, take lag-1, lag-2, etc. difference to see if smoothing occurs
# 4. now ready for Stationary ARIMA modeling
# look at link: https://towardsdatascience.com/the-complete-guide-to-time-series-analysis-and-forecasting-70d476bfe775
