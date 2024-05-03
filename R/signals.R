#' Get  Signals Data
#'
#' Retrieves signals data for a specified stock symbol and model from the Limex API.
#' The function uses the API token that is stored in the 'LIMEX_API_TOKEN' environment variable.
#'
#' @param vendor The vendor name associated with the signals data.
#' @param model The model identifier for which signals data is requested.
#' @param symbol The stock symbol for which signals data is requested.
#' @param from The start date for the signals data retrieval in 'YYYY-MM-DD' format.
#' @param to The end date for the signals data retrieval in 'YYYY-MM-DD' format.
#' @return A data frame containing the signals data if the request is successful; NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   signals_data <- signals(vendor = "boosted", symbol = "AAPL")
#' }
#' @export
signals <- function(vendor='boosted', model='50678d2d-fd0f-4841-aaee-7feac83cb3a1', symbol='AAPL', from='2010-01-01', to=Sys.Date()) {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it before making API calls.")
  }

  # Construct the URL with the provided parameters
  url <- sprintf('https://hub.limex.com/v1/signals/?vendor=%s&model=%s&symbol=%s&from=%s&to=%s&token=%s',
                 vendor, model, symbol, from, to, token)

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
