% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/extractMDFR.Surveys.Abundance.R
\name{extractMDFR.Surveys.Abundance}
\alias{extractMDFR.Surveys.Abundance}
\title{Function to extract estimated survey abundance by year among several models as a dataframe}
\usage{
extractMDFR.Surveys.Abundance(
  objs,
  fleets = "all",
  cast = "x",
  years = "all",
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{fleets}{- names of fleets to include (or "all")}

\item{cast}{- casting formula for excluding x,m,s,z factor levels from sums across the unspecified factors}

\item{years}{- 'all' or vector of years to include}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
a dataframe in canonical format
}
\description{
This function extracts estimated survey abundance by year
  among several models as a dataframe.
}
\details{
None.
}
