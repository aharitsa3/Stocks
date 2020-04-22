library(tidyquant)
library(dplyr)
library(ggplot2)
library(xts)
library(cpm)
library(forecast)


for (stock in c('AAPL','MSFT','SBUX','GOOG')){
  getSymbols(stock,from='2016-01-01',to='2020-04-01',auto.assign = TRUE)
}

# ggplot(data=MSFT,aes(index(MSFT),MSFT.Adjusted)) +
#   geom_line() +
#   geom_line(data = AAPL, aes(index(AAPL),AAPL.Adjusted,col='red')) +
#   geom_line(data = SBUX, aes(index(SBUX),SBUX.Adjusted,col='green'))

df <- data.frame(date=index(AAPL),coredata(AAPL))
a <- processStream(df$AAPL.Adjusted,cpmType = 'Kolmogorov-Smirnov')

# get detection points
df %>% 
  filter(row_number() %in% a[["detectionTimes"]]) %>%
  View()

df <- df %>%
  mutate(rownum = row_number())

changepoints <- data.frame(rownum = a[['detectionTimes']]) %>%
  mutate(cpd=1)

# attach changepoints to dataframe
b <- df %>%
  merge(changepoints,by='rownum',all.x=T) %>%
  mutate(lag1 = lag(AAPL.Adjusted,1),
         lag2 = lag(AAPL.Adjusted,2),
         lag3 = lag(AAPL.Adjusted,3),
         lag4 = lag(AAPL.Adjusted,4),
         lag5 = lag(AAPL.Adjusted,5),
         lag6 = lag(AAPL.Adjusted,6),
         lag7 = lag(AAPL.Adjusted,7),
         lag8 = lag(AAPL.Adjusted,8),
         lag9 = lag(AAPL.Adjusted,9),
         lag10 = lag(AAPL.Adjusted,10),
         prediction = (lag1+lag2+lag3+lag4+lag5+lag6+lag7+lag8+lag9+lag10)/10,
         error = AAPL.Adjusted - prediction,
         cpd = ifelse(is.na(cpd),0,cpd))


# ggplot(data=b,aes(date,AAPL.Adjusted)) + 
#   geom_line() +
#   geom_line(data=b,aes(date,prediction,col='red'))

# model <- ts(df$AAPL.Adjusted,frequency=365)

modelfit <- auto.arima(df$AAPL.Adjusted,lambda = 'auto')
summary(modelfit)
plot(modelfit$residuals)
hist(modelfit$residuals)
preds <- forecast(modelfit,h = 30)
plot(preds)
