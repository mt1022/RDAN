#' Split a data frame by a column expression
#'
#' A tidyverse-style wrapper around base::split() that allows you to 
#' refer to columns directly without using the $ operator or quotes.
#'
#' @param data A data frame or tibble.
#' @param f A column name (unquoted) or an expression to split by.
#' @param ... Additional arguments passed to base::split().
#'
#' @return A list of data frames.
#' @export
#'
#' @examples
#' # 1. Using the new split_by with the native pipe
#' iris |> split_by(Species)
#' 
#' # 2. Comparison with base::split (requires $ or placeholder)
#' split(iris, iris$Species)
split_by <- function(data, f, ...) {
  split(data, f = rlang::eval_tidy(rlang::enquo(f), data), ...)
}

