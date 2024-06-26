% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/news.R
\name{news}
\alias{news}
\title{Get News Data}
\usage{
news(symbol = "AAPL", from = "2023-07-31", to = "2023-08-24")
}
\arguments{
\item{symbol}{The stock symbol for which news data is requested.}

\item{from}{The start date for the data retrieval in 'YYYY-MM-DD' format.}

\item{to}{The end date for the data retrieval in 'YYYY-MM-DD' format.}
}
\value{
A data frame containing the news data if successful, NULL otherwise.
}
\description{
Retrieves news data for a specific stock symbol from the Limex API.
The API token is retrieved from an environment variable 'LIMEX_API_TOKEN'.
}
\examples{
\dontrun{
  news_data <- news(symbol = "BRX", from = "2023-11-27", to = "2023-11-28")
}
}
