import yfinance as yf
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.holtwinters import ExponentialSmoothing, SimpleExpSmoothing, Holt
from scipy import stats


# steps for time series analysis of stocks:
# 1. find moving average, exponential smoothing and double exponential smoothing plots
# 2. find if data is stationary by applying Dickey-Fuller test
# 3. if not stationary, take lag-1, lag-2, etc. difference to see if smoothing occurs
# 4. now ready for Stationary ARIMA modeling
# look at link: https://towardsdatascience.com/the-complete-guide-to-time-series-analysis-and-forecasting-70d476bfe775


company = "AAPL"
data = yf.Ticker(company).history('10y').reset_index()


tsdata = data["Close"]


ts_ma = tsdata.rolling(30).mean()
# plt.plot(tsdata)
# plt.plot(ts_ma)
# plt.show()


simp_model = SimpleExpSmoothing(tsdata)
simp_model_fit = simp_model.fit()
# print(simp_model_fit.summary())


double_model = ExponentialSmoothing(tsdata,trend='add')
double_model_fit = double_model.fit(use_boxcox=True)

# print(double_model_fit.summary())
# print(double_model_fit.forecast(10))

# print(double_model_fit.predict(1250,1300))

plt.plot(tsdata)
plt.plot(double_model_fit.fittedvalues)
plt.show()

print(double_model_fit.fcastvalues)








log_ts = tsdata**(-1/3)
print(log_ts)

# plt.plot(tsdata)
plt.plot(log_ts)
plt.show()




ExponentialSmoothing(log_ts,trend='add')
double_model_fit = double_model.fit(use_boxcox=True)
print(double_model_fit.summary())







# plt.hist(log_ts,bins=30)
# plt.show()




boxts = stats.boxcox(tsdata)
print(boxts)


plt.plot(boxts[0])
plt.show()
















## apply dickey-fuller test to tsdata








































# stocklist = ['AAPL']
# data = yf.download(stocklist,'2010-01-01','2020-04-21')['Adj Close']


# data.plot()
# plt.show()


############################################################################

# average price of a stock in the s&p 500 portfolio
# price = 3193/500
# price = 0
# skip = 200

# abbrev = "AAPL"

# company = yf.Ticker(abbrev).history(period='10y')

# print(company["2020"])

# plt.plot(company['Close'].iloc[:200])
# plt.show()



# company_log = np.log(company)
# plt.plot(company_log['Close'].iloc[:200])
# plt.show()

# moving_avg = company_log.rolling(14).mean()
# plt.plot(moving_avg["Close"].iloc[:200])
# plt.show()


# company_ma_diff = company_log - moving_avg
# company_ma_diff.dropna()


# plt.plot(company_ma_diff["Close"].iloc[:400])
# ma_diff_rolling_avg = company_ma_diff.rolling(7).mean()
# ma_diff_rolling_std = company_ma_diff.rolling(7).std()


# plt.plot(ma_diff_rolling_avg["Close"].iloc[:400],color='red')
# plt.plot(ma_diff_rolling_std["Close"].iloc[:400],color='green')

# plt.show()















# # bypass the first 200 days to get a fair estimate 
# # of what the true stock price of company is 
# for index,(timestamp,row) in enumerate(company.head(n=skip).iterrows()):
#     price += row["Close"]


# company = company.reset_index()
# company["Prediction"] = 0
# for index, row in company.iloc[skip:].iterrows():
#     company.loc[index,"Prediction"] = price/(index+1)
#     price = company.loc[index,"Prediction"]

#     company.loc[index,"Prediction"] = (price + row["Close"])/(skip + index + 1)
#     price += row["Close"]


# # print(company.iloc[50:100])

# # company = company.sort_values("Close")
# print(company)