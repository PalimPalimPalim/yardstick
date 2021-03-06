% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metrics.R
\name{metric_set}
\alias{metric_set}
\title{Combine metric functions}
\usage{
metric_set(...)
}
\arguments{
\item{...}{The bare names of the functions to be included in the metric set.}
}
\description{
\code{metric_set()} allows you to combine multiple metric functions together
into a new function that calculates all of them at once.
}
\details{
All functions must be either:
\itemize{
\item Only numeric metrics
\item A mix of class metrics or class prob metrics
}

For instance, \code{rmse()} can be used with \code{mae()} because they
are numeric metrics, but not with \code{accuracy()} because it is a classification
metric. But \code{accuracy()} can be used with \code{roc_auc()}.

The returned metric function will have a different argument list
depending on whether numeric metrics or a mix of class/prob metrics were
passed in.\preformatted{# Numeric metric set signature:
fn(
  data,
  truth,
  estimate,
  na_rm = TRUE,
  ...
)

# Class / prob metric set signature:
fn(
  data,
  truth,
  ...,
  estimate,
  estimator =  NULL,
  na_rm = TRUE,
  event_level = yardstick_event_level()
)
}

When mixing class and class prob metrics, pass in the hard predictions
(the factor column) as the named argument \code{estimate}, and the soft
predictions (the class probability columns) as bare column names or
\code{tidyselect} selectors to \code{...}.
}
\examples{
library(dplyr)

# Multiple regression metrics
multi_metric <- metric_set(rmse, rsq, ccc)

# The returned function has arguments:
# fn(data, truth, estimate, na_rm = TRUE, ...)
multi_metric(solubility_test, truth = solubility, estimate = prediction)

# Groups are respected on the new metric function
class_metrics <- metric_set(accuracy, kap)

hpc_cv \%>\%
  group_by(Resample) \%>\%
  class_metrics(obs, estimate = pred)

# ---------------------------------------------------------------------------

# If you need to set options for certain metrics,
# do so by wrapping the metric and setting the options inside the wrapper,
# passing along truth and estimate as quoted arguments.
# Then add on the function class of the underlying wrapped function,
# and the direction of optimization.
ccc_with_bias <- function(data, truth, estimate, na_rm = TRUE, ...) {
  ccc(
    data = data,
    truth = !! rlang::enquo(truth),
    estimate = !! rlang::enquo(estimate),
    # set bias = TRUE
    bias = TRUE,
    na_rm = na_rm,
    ...
  )
}

# Use `new_numeric_metric()` to formalize this new metric function
ccc_with_bias <- new_numeric_metric(ccc_with_bias, "maximize")

multi_metric2 <- metric_set(rmse, rsq, ccc_with_bias)

multi_metric2(solubility_test, truth = solubility, estimate = prediction)

# ---------------------------------------------------------------------------
# A class probability example:

# Note that, when given class or class prob functions,
# metric_set() returns a function with signature:
# fn(data, truth, ..., estimate)
# to be able to mix class and class prob metrics.

# You must provide the `estimate` column by explicitly naming
# the argument

class_and_probs_metrics <- metric_set(roc_auc, pr_auc, accuracy)

hpc_cv \%>\%
  group_by(Resample) \%>\%
  class_and_probs_metrics(obs, VF:L, estimate = pred)

}
\seealso{
\code{\link[=metrics]{metrics()}}
}
