#' Get Instruments Data
#'
#' Retrieves instruments data filtered by asset type. This function
#' uses an API token stored in an environment variable named 'LIMEX_API_TOKEN'.
#'
#' @param assets Type of assets to query, by default 'stocks'.
#' @return A data frame containing instrument data, or NULL if the request fails.
#' @import jsonlite
#' @import httr
#' @import data.table
#' @examples
#' \dontrun{
#'   instruments_data <- instruments(assets = 'stocks')
#' }
#' @export
instruments <- function(assets = 'stocks') {
  # Retrieve the API token from the environment variable
  token <- Sys.getenv('LIMEX_API_TOKEN')

  # Check if the token has been set
  if (token == "") {
    stop("API token is not set. Use set_limex_token() to set it.")
  }

  # Construct the API request URL with the specified parameters
  url <- sprintf('https://hub.limex.com/v1/instruments?assets=%s', assets)

  # Append the token parameter to the URL
  url <- paste0(url, "&token=", token)

  data <- tryCatch({
    response <- fromJSON(url, simplifyMatrix = TRUE)
    data = data.table(response)
  }, error = function(e) {
    message("An error occurred: ", e$message)
    return(NULL)
  })

  return(data)
}
