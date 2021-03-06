# File is named with `aaa-` so that it is loaded before any other files. We need
# to call `new_*_metric()` internally from outside any function in the package,
# so this file has to be sourced first. It is a bit of a hack, but works.

# ------------------------------------------------------------------------------

#' Construct a new metric function
#'
#' @description
#' These functions provide convenient wrappers to create the three types of
#' metric functions in yardstick: numeric metrics, class metrics, and
#' class probability metrics. They add a metric-specific class to `fn` and
#' attach a `direction` attribute. These features are used by [metric_set()]
#' and by [tune](https://tune.tidymodels.org/) when model tuning.
#'
#' See `vignette("custom-metrics")` for more information about creating custom
#' metrics.
#'
#' @param fn A function. The metric function to attach a metric-specific class
#'   and `direction` attribute to.
#'
#' @param direction A string. One of:
#'   - `"maximize"`
#'   - `"minimize"`
#'   - `"zero"`
#'
#' @name new-metric
NULL

#' @rdname new-metric
#' @export
new_class_metric <- function(fn, direction) {
  new_metric(fn, direction, class = "class_metric")
}

#' @rdname new-metric
#' @export
new_prob_metric <- function(fn, direction) {
  new_metric(fn, direction, class = "prob_metric")
}

#' @rdname new-metric
#' @export
new_numeric_metric <- function(fn, direction) {
  new_metric(fn, direction, class = "numeric_metric")
}

new_metric <- function(fn, direction, class = NULL) {
  if (!is.function(fn)) {
    rlang::abort("`fn` must be a function.")
  }

  direction <- rlang::arg_match(
    direction,
    values = c("maximize", "minimize", "zero")
  )

  class <- c(class, "metric", "function")

  structure(
    fn,
    direction = direction,
    class = class
  )
}
