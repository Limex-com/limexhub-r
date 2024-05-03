#' Set API Token for Limex
#'
#' Sets the API token for the Limex service by storing it in an
#' environment variable for the current R session. This token will be used by
#' other functions in the package to authenticate API requests.
#'
#' @param token API token for the Limex service.
#' @return Invisible NULL, side-effect function setting an environment variable.
#' @examples
#' \dontrun{
#'   limex_token("your_personal_token_here")
#' }
#' @export
limex_token <- function(token) {
  if (nzchar(token)) {
    Sys.setenv(LIMEX_API_TOKEN = token)
    message("API token is set for the current session.")
  } else {
    stop("Invalid token. Token must be a non-empty string.")
  }
  invisible(NULL)
}




