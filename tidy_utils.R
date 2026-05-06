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

#' Format p-values in scientific notation for plotmath/ggplot2
#'
#' Converts numeric p-values into plotmath expressions suitable for use in
#' ggplot2 annotations (with `parse = TRUE`), using scientific notation.
#'
#' Internally uses `scales::scientific_format()` and converts the output
#' into plotmath syntax (e.g., `1.3 %*% 10^{-3}`), prefixed with `P ==`.
#'
#' @param p Numeric vector of p-values.
#' @param digits Integer; number of significant digits to display
#'   (passed to `scales::scientific_format()`).
#'
#' @return A character vector of plotmath expressions.
#'
#' @details
#' The output is designed for use with ggplot2 annotations where
#' `parse = TRUE`. For example:
#'
#' \preformatted{
#' ggplot(df, aes(x, y)) +
#'   geom_point() +
#'   annotate("text", x = 1, y = 1,
#'            label = format_p_scientific(1.3e-3),
#'            parse = TRUE)
#' }
#'
#' Note that this function returns plotmath expressions, not LaTeX.
#'
#' @examples
#' format_p_scientific(1.3e-3)
#' format_p_scientific(c(0.05, 2.5e-8))
#'
#' @export
format_p_sci <- function(p, digits = 2) {
    sci <- scales::scientific_format(digits = digits)(p)
    
    # Convert "1.3e-03" → "1.3 %*% 10^{-3}"
    sci <- gsub("e", " %*% 10^", sci)
    
    # Wrap exponent in braces for plotmath
    sci <- gsub("\\^(\\-?\\d+)", "^{\\1}", sci)
    
    paste0("italic(P) == ", sci)
}
