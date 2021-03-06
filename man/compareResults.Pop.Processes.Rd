% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compareResults.Pop.Processes.R
\name{compareResults.Pop.Processes}
\alias{compareResults.Pop.Processes}
\title{Compare population processes from TCSAM2013 and TCSAM02 model runs}
\usage{
compareResults.Pop.Processes(
  objs,
  showPlot = TRUE,
  pdf = NULL,
  width = 8,
  height = 6,
  verbose = FALSE
)
}
\arguments{
\item{objs}{- list of resLst objects}

\item{showPlot}{- flag to show/print plots immediately}

\item{pdf}{- name of pdf file to record plot output to}

\item{width}{- pdf page width (in inches)}

\item{height}{- pdf page width (in inches)}

\item{verbose}{- flag (T/F) to print debug info}
}
\value{
list of ggplot2 objects.
}
\description{
Function to compare population processes from TCSAM2013 and TCSAM02 model runs.
}
\details{
Uses \code{wtsUtilities::printGGList()}. List names are captions.
}
