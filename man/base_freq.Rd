% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base_freq.r
\name{base_freq}
\alias{base_freq}
\title{Overall nucleotides frequency}
\usage{
base_freq(x)
}
\arguments{
\item{x}{a list of KZsqns objects.}
}
\value{
a n-by-4 numeric matrix, where n is the length of list x
}
\description{
Calculate the overall nucleotides frequency composition
}
\examples{
data(CodonTable0)
x = vector('list', 5) # Creating an empty list of length 5

for(i in 1:5){
x[[i]] = CodonTable0[sample(1:64, 10*i, TRUE),1]
attr(x[[i]], 'class') = 'KZsqns'
}

cat(base_freq(x))
}
