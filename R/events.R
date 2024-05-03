#' Get Instruments Events Data
#'
#' Retrieves events data for a specified stock symbol, filtered by event type and date range.
#' Utilizes the API token set as an environment variable 'LIMEX_API_TOKEN'.
#'
#' @param symbol The stock symbol for which events data is requested.
#' @param from The start date for the data retrieval in 'YYYY-MM-DD' format.
#' @param to The end date for the data retrieval in 'YYYY-MM-DD' format.
#' @param type Type of the event to filter (e.g., 'dividends').
#' @return A data frame containing the events data if the request is successful, NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   events_data <- events(symbol = "AAPL", from = "2023-01-01", to = "2024-01-01")
#' }
#' @export
events <- function(symbol='AAPL', from = "2023-07-31", to = "2023-08-24", type='dividends') {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')
  # Ensure the token has been set
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it before making API calls.")
  }

  # Construct the URL with the provided parameters
  url <- sprintf('https://hub.limex.com/v1/events/?symbol=%s&from=%s&to=%s&type=%s&token=%s',
                 symbol, from, to, type, token)

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
