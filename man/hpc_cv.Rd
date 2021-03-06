% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{hpc_cv}
\alias{hpc_cv}
\title{Multiclass Probability Predictions}
\source{
Kuhn, M., Johnson, K. (2013) \emph{Applied Predictive
Modeling}, Springer
}
\value{
\item{hpc_cv}{a data frame}
}
\description{
Multiclass Probability Predictions
}
\details{
This data frame contains the predicted classes and
class probabilities for a linear discriminant analysis model fit
to the HPC data set from Kuhn and Johnson (2013). These data are
the assessment sets from a 10-fold cross-validation scheme. The
data column columns for the true class (\code{obs}), the class
prediction (\code{pred}) and columns for each class probability
(columns \code{VF}, \code{F}, \code{M}, and \code{L}). Additionally, a column for
the resample indicator is included.
}
\examples{
data(hpc_cv)
str(hpc_cv)

# `obs` is a 4 level factor. The first level is `"VF"`, which is the
# "event of interest" by default in yardstick. See the Relevant Level
# section in any classification function (such as `?pr_auc`) to see how
# to change this.
levels(hpc_cv$obs)
}
\keyword{datasets}
