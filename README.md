# Limexhub
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/limexhub)](https://cran.r-project.org/package=limexhub) [![CRAN_Downloads](https://cranlogs.r-pkg.org/badges/last-month/limexhub)](https://cran.r-project.org/package=limexhub) [![CRAN_Ago](https://www.r-pkg.org/badges/ago/limexhub)](https://cran.r-project.org/package=limexhub)
 
`limexhub` is a comprehensive R library designed to simplify interactions with the financial data and services provided by Limex DataHub. It provides an easy-to-use interface for fetching various types of financial data, including instruments, candles, fundamentals, news, events, and predictive signals.
 
## Features
 
- **Ease of Use**: The `limexhub` library has a straightforward, intuitive interface that enables quick access to Limex DataHub.
- **Comprehensive Data Coverage**: Access a wide range of financial data, from market instruments and historical candlestick charts to company fundamentals and latest news.
- **Predictive Signals**: Leverage advanced machine learning models and signals to inform your financial decisions.
- **Customization**: Easily customize your data queries with flexible parameters suitable for different analysis and trading strategies.
- **Efficiency**: The library is designed for efficiency, minimizing the amount of code needed to make requests and handle responses.
 
## Installation
 
Install `limexhub` from CRAN:
 
```r
install.packages('limexhub')
```



### Getting Started

The library needs to be configured with an API key from your account. [Sign up](https://datahub.limex.com) for free and you will automatically receive a set of API keys to start with.
``` r
library(limexhub)
limex_token("your_api_key")



instruments_data <- instruments(assets = 'stocks')


candles(symbol="AAPL", 
        to_date="2024-01-01", 
        from_date="2023-01-01", 
        timeframe=3)

fundamental(symbol="AAPL", 
            from_date="2023-01-01",
            to_date="2024-01-01")
            
                                 
events(symbol="AAPL",
              from_date="2023-01-01", 
              to_date="2024-01-01",
              event_type="dividends")

news(symbol="AAPL", 
     from_date="2023-03-01",
     to_date="2024-03-03")

models(vendor = 'boosted')
    
signals(vendor="boosted", 
        symbol="AAPL", 
        from_date="2023-01-01")

```
