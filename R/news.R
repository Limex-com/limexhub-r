#' Get News Data
#'
#' Retrieves news data for a specific stock symbol from the Limex API.
#' The API token is retrieved from an environment variable 'LIMEX_API_TOKEN'.
#'
#' @param symbol The stock symbol for which news data is requested.
#' @param from The start date for the data retrieval in 'YYYY-MM-DD' format.
#' @param to The end date for the data retrieval in 'YYYY-MM-DD' format.
#' @return A data frame containing the news data if successful, NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   news_data <- news(symbol = "BRX", from = "2023-11-27", to = "2023-11-28")
#' }
#' @export
news <- function(symbol='AAPL', from = "2023-07-31", to = "2023-08-24") {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it before making API calls.")
  }

  # Construct the URL with the provided parameters
  url <- sprintf('https://hub.limex.com/v1/news?symbol=%s&from=%s&to=%s&token=%s',
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
