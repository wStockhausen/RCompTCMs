% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareFits.MaturityOgiveData.R
\name{compareFits.MaturityOgiveData}
\alias{compareFits.MaturityOgiveData}
\title{Compare fits to maturity ogive data among several model runs}
\usage{
compareFits.MaturityOgiveData(
  objs,
  nyrs = 5,
  types = c("fits", "nlls", "zscores"),
  minSize = 0,
  dodge = 0.2,
  plot1stObs = FALSE,
  pdf = NULL,
  showPlot = FALSE,
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{nyrs}{- number of years/plot}

\item{types}{- requested plot types ("fits","nlls",and/or "zscores")}

\item{minSize}{- minimum size to include in plots}

\item{dodge}{- width to dodge overlapping series}

\item{plot1stObs}{- flag to include observations only from 1st model scenario}

\item{pdf}{- name for output pdf file}

\item{showPlot}{- flag to print plot to current device}

\item{verbose}{- flag (T/F) to print diagnostic information}
}
\value{
ggplot object
}
\description{
Function to compare fits to maturity ogive data among several model runs.
}
\details{
None.
}
