#' Retrieve Models Data from Limex API
#'
#' Fetches data about models from the Limex API for a specified vendor.
#' It uses an API token that is stored in the 'LIMEX_API_TOKEN' environment variable.
#'
#' @param vendor The name of the vendor for which models data is requested.
#' @return A data frame containing the models data if the request is successful; NULL otherwise.
#' @import jsonlite
#' @import httr
#' @examples
#' \dontrun{
#'   models_data <- models(vendor = "boosted")
#' }
#' @export
models <- function(vendor='boosted') {
  # Check if the API token is available in the current environment
  token <- Sys.getenv('LIMEX_API_TOKEN')
  if (token == "") {
    stop("API token is not set. Please set it using `set_limex_token()` before making any API calls.")
  }

  # Construct the API request URL
  url <- sprintf('https://hub.limex.com/v1/models/?vendor=%s&token=%s', vendor, token)

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
