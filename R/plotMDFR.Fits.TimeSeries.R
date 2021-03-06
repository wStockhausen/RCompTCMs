#'
#'@title Plot comparisons of fits to time series from a set of model runs, with a "zoom" for recent years
#'
#'@description Function to plot a comparison of fits to time series from a set of model runs, with a "zoom" for recent years.
#'
#'@param dfr - dataframe
#'@param plot1stObs - flag to plot observations from first case only
#'@param numRecent - number of "recent" years to plot
#'@param x - column name with x axis values
#'@param y - column name with y axis values
#'@param lci - column name with y axis values
#'@param uci - column name with y axis values
#'@param case - column name with case names
#'@param type - column name with type values (i.e., "observed","predicted")
#'@param facets - string giving faceting formula
#'@param scales - ggplot2 scales option for facet_grid
#'@param position - indicates ggplot2 position_ to use ('dodge','jitter','identity',)
#'@param plotObs - plot observations
#'@param plotMod - plot model fits/predictions
#'@param xlab -
#'@param ylab -
#'@param title -
#'@param xlims -
#'@param ylims -
#'@param colour_scale - ggplot2 scale_colour object (default is ggplot2::scale_colour_hue())
#'@param showPlot - flag (T/F) to print plot
#'
#'@details numRecent provides the "zoom" for a second set of faceted plots including
#'only the most recent years. Calls \code{plotMDFR.Fits.TimeSeries1}.
#'
#'@return list with requested ggplot objects
#'
#'@export
#'
plotMDFR.Fits.TimeSeries<-function(dfr,
                                  plot1stObs=TRUE,
                                  numRecent=15,
                                  x="y",
                                  y="val",
                                  lci="lci",
                                  uci="uci",
                                  case="case",
                                  type="type",
                                  facets=NULL,
                                  scales="fixed",
                                  position=ggplot2::position_dodge(0.2),
                                  plotObs=TRUE,
                                  plotMod=TRUE,
                                  xlab='year',
                                  ylab=NULL,
                                  title=NULL,
                                  xlims=NULL,
                                  ylims=NULL,
                                  colour_scale=ggplot2::scale_color_hue(),
                                  showPlot=FALSE){
    plots<-list();

    #plot with observations & case results
    if (plotObs&&plotMod){
        p1<-plotMDFR.Fits.TimeSeries1(dfr,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=TRUE,
                                      plotMod=TRUE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xlims,
                                      ylims=ylims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p1<-p1;

        #plot only over time period with observations
        idx<-dfr[[type]]=='observed';
        xplims<-range(dfr[[x]][idx],na.rm=TRUE);
        if (!is.null(xlims)){
            xplims[1]<-max(xlims[1],xplims[1],na.rm=TRUE);#max of mins
            xplims[2]<-min(xlims[2],xplims[2],na.rm=TRUE);#min of maxes
        }
        yplims<-NULL;
        if (!is.null(ylims)){
            idy<-dfr[[x]] %in% xplims[1]:xplims[2];
            yplims<-range(dfr[[y]][idy],na.rm=TRUE,finite=TRUE);
            yplims[1]<-max(ylims[1],yplims[1],na.rm=TRUE);#max of mins
            yplims[2]<-min(ylims[2],yplims[2],na.rm=TRUE);#min of maxes
        }
        dfrp<-dfr[(dfr[[x]]>=xplims[1])&(dfr[[x]]<=xplims[2]),];
        p2<-plotMDFR.Fits.TimeSeries1(dfrp,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=TRUE,
                                      plotMod=TRUE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xplims,
                                      ylims=yplims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p2<-p2;

        #plot in recent years only
        xmx<-max(dfr[[x]],na.rm=TRUE);
        xplims<-c(xmx-numRecent,xmx+1);
        if (!is.null(xlims)){
            xplims[1]<-max(xlims[1],xplims[1],na.rm=TRUE);#max of mins
            xplims[2]<-min(xlims[2],xplims[2],na.rm=TRUE);#min of maxes
        }
        yplims<-NULL;
        if (!is.null(ylims)){
            idy<-dfr[[x]] %in% xplims[1]:xplims[2];
            yplims<-range(dfr[[y]][idy],na.rm=TRUE,finite=TRUE);
            yplims[1]<-max(ylims[1],yplims[1],na.rm=TRUE);#max of mins
            yplims[2]<-min(ylims[2],yplims[2],na.rm=TRUE);#min of maxes
        }
        dfrp<-dfr[dfr[[x]]>=(xmx-numRecent),];
        p3<-plotMDFR.Fits.TimeSeries1(dfrp,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=TRUE,
                                      plotMod=TRUE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xplims,
                                      ylims=yplims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p3<-p3;
    }

    #plot with observations only
    if (plotObs&&(!plotMod)){
        p1<-plotMDFR.Fits.TimeSeries1(dfr,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=TRUE,
                                      plotMod=FALSE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xlims,
                                      ylims=ylims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p1<-p1;
        #plot in recent years only
        xmx<-max(dfr[[x]],na.rm=TRUE);
        xplims<-c(xmx-numRecent,xmx+1);
        if (!is.null(xlims)){
            xplims[1]<-max(xlims[1],xplims[1],na.rm=TRUE);#max of mins
            xplims[2]<-min(xlims[2],xplims[2],na.rm=TRUE);#min of maxes
        }
        yplims<-NULL;
        if (!is.null(ylims)){
            idy<-dfr[[x]] %in% xplims[1]:xplims[2];
            yplims<-range(dfr[[y]][idy],na.rm=TRUE,finite=TRUE);
            yplims[1]<-max(ylims[1],yplims[1],na.rm=TRUE);#max of mins
            yplims[2]<-min(ylims[2],yplims[2],na.rm=TRUE);#min of maxes
        }
        dfrp<-dfr[dfr[[x]]>=(xmx-numRecent),];
        p2<-plotMDFR.Fits.TimeSeries1(dfrp,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=TRUE,
                                      plotMod=FALSE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xplims,
                                      ylims=yplims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p2<-p2;
    }

    #plot with case results only
    if (plotMod&&(!plotObs)){
        #plot full time series
        p1<-plotMDFR.Fits.TimeSeries1(dfr,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=FALSE,
                                      plotMod=TRUE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xlims,
                                      ylims=ylims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p1<-p1;
        #plot in recent years only
        xmx<-max(dfr[[x]],na.rm=TRUE);
        xplims<-c(xmx-numRecent,xmx+1);
        if (!is.null(xlims)){
            xplims[1]<-max(xlims[1],xplims[1],na.rm=TRUE);#max of mins
            xplims[2]<-min(xlims[2],xplims[2],na.rm=TRUE);#min of maxes
        }
        yplims<-NULL;
        if (!is.null(ylims)){
            idy<-dfr[[x]] %in% xplims[1]:xplims[2];
            yplims<-range(dfr[[y]][idy],na.rm=TRUE,finite=TRUE);
            yplims[1]<-max(ylims[1],yplims[1],na.rm=TRUE);#max of mins
            yplims[2]<-min(ylims[2],yplims[2],na.rm=TRUE);#min of maxes
        }
        dfrp<-dfr[dfr[[x]]>=(xmx-numRecent),];
        p2<-plotMDFR.Fits.TimeSeries1(dfrp,
                                      plot1stObs=plot1stObs,
                                      x=x,
                                      y=y,
                                      lci=lci,
                                      uci=uci,
                                      case=case,
                                      type=type,
                                      facets=facets,
                                      scales=scales,
                                      position=position,
                                      plotObs=FALSE,
                                      plotMod=TRUE,
                                      xlab=xlab,
                                      ylab=ylab,
                                      title=title,
                                      xlims=xplims,
                                      ylims=yplims,
                                      colour_scale=colour_scale,
                                      showPlot=showPlot);
        plots$p2<-p2;
    }
    return(plots);
}
