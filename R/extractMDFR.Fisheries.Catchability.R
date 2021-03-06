#'
#'@title Function to extract fishery catchabilities by year using ggplot2
#'
#'@description This function extracts fishery catchability estimates by year,
#'   sex and maturity state.
#'
#'@param objs - list of resLst objects
#'@param fleets - names of fleets to include (or "all")
#'@param years - vector of years to show, or 'all' to show all years
#'@param cast - formula to exclude factors from "averaging" over
#'@param verbose - flag (T/F) to print diagnostic information
#'
#'@return dataframe in canonical format
#'
#'@details None.
#'
#'@export
#'
extractMDFR.Fisheries.Catchability<-function(objs,
                                             fleets="all",
                                             years='all',
                                             cast='x',
                                             verbose=FALSE){
    if (verbose) cat("Starting rCompTCMs::extractMDFR.Fisheries.Catchability().\n");
    options(stringsAsFactors=FALSE);

    cases<-names(objs);

    mdfr<-NULL;
    for (case in cases){
        obj<-objs[[case]];
        if (inherits(obj,"tcsam2013.resLst")) mdfr1<-rTCSAM2013::getMDFR.FisheryQuantities(obj,type="qFsh_xy",verbose);
        if (inherits(obj,"rsimTCSAM.resLst")) mdfr1<-NULL; #rsimTCSAM::getMDFR.Fisheries.Catchability(obj,cast=cast,verbose);
        if (inherits(obj,"tcsam02.resLst"))   mdfr1<-rTCSAM02::getMDFR.Fisheries.Catchability(obj,cast=cast,verbose);
        if (!is.null(mdfr1)){
            if ((!is.null(fleets))&&tolower(fleets[1])!="all") mdfr1<-mdfr1[mdfr1$fleet %in% fleets,];
            mdfr1$case<-case;
            mdfr<-rbind(mdfr,mdfr1);
        }
    }
    mdfr$y<-as.numeric(mdfr$y)
    mdfr$case<-factor(mdfr$case,levels=cases);

    if (is.numeric(years)) mdfr <- mdfr[as.numeric(mdfr$y) %in% years,];

    if (verbose) cat("Finished rCompTCMs::extractMDFR.Fisheries.Catchability().\n");
    return(mdfr)
}
