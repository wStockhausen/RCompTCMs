#'
#'@title Compare z-scores from fitting biomass time series by fleet among several model runs
#'
#'@description Function to compare z-scores from fitting biomass time series by fleet among 
#'several model runs.
#'
#'@param obj - object that can be converted into a list of tcsam2013.resLst and/or tcsam02.resLst objects
#'@param fleet.type - fleet type ('fishery' or 'survey')
#'@param catch.type - catch type ('index','retained', 'discard', or 'total')
#'@param showPlot - flag (T/F) to show plot
#'@param pdf - name for output pdf file
#'
#'@details Uses \code{rTCSAM2013::getMDFR.SurveyQuantities()},
#'\code{rTCSAM2013::getMDFR.FisheryQuantities()}, \code{rTCSAM02::getMDFR.ZScores.ABData()}.
#'Also uses \code{wtsUtilities::printGGList}.
#'
#'@return non-nested list of ggplot2 objects, with captions as names
#'
#'@import ggplot2
#'
#'@export
#'
compareFits.ZScores.Biomass<-function(objs=NULL,
                                     fleet.type=c('survey','fishery'),
                                     catch.type=c('index','retained','discard','total'),
                                     showPlot=FALSE,
                                     pdf=NULL,
                                     verbose=FALSE){
    
    if (verbose) cat("Starting rCompTCMs::compareFits.ZScores.Biomass().\n");
    options(stringsAsFactors=FALSE);
    
    fleet.type<-fleet.type[1];
    catch.type<-catch.type[1];

    if (fleet.type=='survey') catch.type<-'index';

    cases<-names(objs);

    #create pdf, if necessary
    if(!is.null(pdf)){
        pdf(file=pdf,width=11,height=8,onefile=TRUE);
        on.exit(dev.off());
        showPlot<-TRUE;
    }
    
    if (catch.type=='retained') type<-'zscores.ret';
    if (catch.type=='discard')  type<-'zscores.dsc';
    if (catch.type=='total')    type<-'zscores.tot';
    
    mdfr<-NULL;
    for (case in cases){
        obj<-objs[[case]];
        if (verbose) cat("Processing '",case,"', a ",class(obj)[1]," object.\n",sep='');
        if (inherits(obj,"rsimTCSAM.resLst")) mdfr1<-NULL;
        if (fleet.type=='survey'){
            if (inherits(obj,"tcsam2013.resLst")) 
                mdfr1<-rTCSAM2013::getMDFR.SurveyQuantities(obj,
                                                            type='zscores',
                                                            verbose=verbose);
            if (inherits(obj,"tcsam02.resLst"))   
                mdfr1<-rTCSAM02::getMDFR.ZScores.Biomass(obj,
                                                         fleet.type=fleet.type,
                                                         catch.type='index',
                                                         verbose=verbose);
        }
        if (fleet.type=='fishery'){
            if (inherits(obj,"tcsam2013.resLst")) 
                mdfr1<-rTCSAM2013::getMDFR.FisheryQuantities(obj,
                                                             type=type,
                                                             verbose=verbose);
            if (inherits(obj,"tcsam02.resLst"))   
                mdfr1<-rTCSAM02::getMDFR.ZScores.Biomass(obj,
                                                         fleet.type=fleet.type,
                                                         catch.type=catch.type,
                                                         verbose=verbose);
        }
        if (!is.null(mdfr1)){
            mdfr1$case<-case;
            mdfr<-rbind(mdfr,mdfr1);
        }
    }
    mdfr$case<-factor(mdfr$case,levels=cases);
    mdfr$y<-as.numeric(mdfr$y);
    mdfr$x[mdfr$x=='all']<-'all sex';
    mdfr$m[mdfr$m=='all']<-'all maturity';
    mdfr$s[mdfr$s=='all']<-'all shell';

    #----------------------------------
    # define output list of plots
    #----------------------------------
    plots<-list();
    figno<-1;
    
    #----------------------------------
    # plot zscores from fits to time series 
    #----------------------------------
    uFs<-unique(mdfr$fleet);
    print(uFs);
    for (uF in uFs){
        idx   <- (mdfr$fleet==uF);
        dfrpp <- mdfr[idx,];
        xmax  <- max(dfrpp$y,na.rm=TRUE);
        p<-plotZScores(dfrpp,x='y',y='val',
                       color='case',shape='case',legend='case',
                       facets="x~fleet",facet.scales='free_y',position='dodge',
                       ylab='z-score',title=uF,
                       showPlot=showPlot);
        cap<-paste0("  \n  \nFigure &&fno. Z-scores for ",catch.type," catch biomass in ",uF,".  \n  \n");
        if (showPlot) figno<-(wtsUtilities::printGGList(p,figno=figno,cap=cap))$figno;
        plots[[cap]]<-p; p<-NULL;
    }

    if (verbose) cat("Finished rCompTCMs::compareFits.ZScores.Biomass().\n");
    return(plots);
}