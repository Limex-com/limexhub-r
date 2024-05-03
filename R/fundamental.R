#' Get Fundamental Data
#'
#' Fetches fundamental data for a specified stock symbol and range of dates,
#' and for specified accounting quarter(s), using the Limex API. Authentication
#' is done via an API token stored in an environment variable 'LIMEX_API_TOKEN'.
#'
#' @param symbol The stock symbol for which fundamental data is requested.
#' @param from The start date for the data retrieval in 'YYYY-MM-DD' format.
#' @param to The end date for the data retrieval in 'YYYY-MM-DD' format.
#' @param quarter Optional; specify the quarter(s) 'q1', 'q2', 'q3', 'q4' for quarterly data.
#' @param fields Optional; specify particular fields of interest like 'roe'.
#' @return A data frame containing the requested fundamental data if successful, NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   fundamental_data <- fundamental(symbol = "AAPL")
#' }
#' @export
fundamental <- function(symbol='AAPL', from = "2023-07-31", to = "2023-08-24", quarter = NULL, fields = NULL) {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it before making API calls.")
  }

  # Construct the URL with the provided parameters
  base_url <- 'https://hub.limex.com/v1/fundamental/'
  url_params <- list(symbol = symbol, token = token, from = from, to = to)

  if (!is.null(quarter)) {
    url_params$quarter <- quarter
  }
  if (!is.null(fields)) {
    url_params$fields <- fields
  }

  # Build the query URL
  url <- paste0(base_url, '?',
                      paste0(names(url_params), '=', url_params, collapse = '&'))

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
