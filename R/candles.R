#' Get Candlestick Data
#'
#' Retrieves historical candlestick data for a given stock symbol
#' within the specified date range. The API token is retrieved from
#' an environment variable 'LIMEX_API_TOKEN'.
#'
#' @param symbol Stock symbol to fetch candlestick data for.
#' @param from Starting date for the candlestick data in 'YYYY-MM-DD' format.
#' @param to Ending date for the candlestick data in 'YYYY-MM-DD' format.
#' @return A data frame containing the candlestick data if the request was successful, NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   candles_data <- candles(symbol = "BRX", from = "2023-07-31", to = "2023-08-24")
#' }
#' @export
candles <- function(symbol='AAPL', from = "2023-07-31", to = "2023-08-24") {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it before making API calls.")
  }

  # Construct the URL with the provided parameters
  url <- sprintf('https://hub.limex.com/v1/candles?symbol=%s&from=%s&to=%s&token=%s',
                 symbol, from, to, token)

  # Use tryCatch to handle errors
  data <- tryCatch({
    response <- fromJSON(url, simplifyMatrix = TRUE)
    data = data.table(response)
    return(data)
  }, error = function(e) {
    message("An error occurred: ", e$message)
    return(NULL)
  })

  return(data)
}
