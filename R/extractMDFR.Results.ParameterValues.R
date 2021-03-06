#'
#'@title Extract parameter values (and associated std devs) from several model runs as a dataframe
#'
#'@description This function extracts parameter values (and associated std devs) from several model runs as a dataframe.
#'   
#'@param objs - list of resLst objects
#'@param verbose - flag (T/F) to print diagnostic information
#'
#'@return dataframe
#'
#'@details Results are extracted using \code{rTCSAM02::getMDFR.Results.ParameterValues} for tcsam02 model runs.
#'
#'@export
#'
extractMDFR.Results.ParameterValues<-function(objs,
                                              verbose=FALSE){
    if (verbose) cat("starting rCompTCMs::extractMDFR.Results.ParameterValues().\n");
    options(stringsAsFactors=FALSE);
    
    cases<-names(objs);

    mdfr<-NULL;
    for (case in cases){
        obj<-objs[[case]];
        if (verbose) cat("Processing '",case,"', a ",class(obj)[1]," object.\n",sep='');
        mdfr1<-NULL;
        if (inherits(obj,"tcsam2013.resLst")) mdfr1<-NULL;
        if (inherits(obj,"rsimTCSAM.resLst")) mdfr1<-NULL;
        if (inherits(obj,"tcsam02.resLst"))   mdfr1<-rTCSAM02::getMDFR.ParameterValues(obj,verbose=verbose);
        if (!is.null(mdfr1)){
            mdfr1$case<-case;
            mdfr<-rbind(mdfr,mdfr1);
        }
    }
    mdfr$case<-factor(mdfr$case,levels=cases);

    if (verbose) cat("finished rCompTCMs::extractMDFR.Results.ParameterValues().\n");
    return(mdfr)
}
