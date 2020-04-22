import yfinance as yf

stocklist = ['AAPL']
data = yf.download(stocklist,'2010-01-01','2020-04-21')['Adj Close']

import matplotlib.pyplot as plt
data.plot()
plt.show()d