#'
#' @title Render a document of comparison plots of estimated fishery characteristics from several models
#'
#' @description Function to render a document of comparison plots of estimated fishery
#' characteristics from several models.
#'
#' @param models - named list of model results (as resLst objects) to compare
#' @param fleets - vector of fisheries to plot, or "all"
#' @param selyears - vector of years to show selectivity functions for, or 'all' to show all years
#' @param retyears - vector of years to show retention functions for, or 'all' to show all years
#' @param output_format - "word_document" or "pdf_document"
#' @param output_dir - path to folder to use for output
#' @param rmd_dir - folder enclosing rmd file
#' @param rmd - Rmd file to process (defalut=system.file("rmd/modelComparisons.EstimatedCharacteristics.Fisheries.Rmd",package="rCompTCMs"))
#' @param docx_styles - full path to Word (docx) style template for Word documents
#' @param pdf_styles - full path to style template for pdf documents
#' @param verbose - flag to print debugging info
#' @param clean - T/F to delete intermediate files
#'
#' @details The default resulting document title will be of the form "ModelComparisons.EstimatedCharacteristics.Fisheries.mmm.ext",
#' where "ext" is the appropriate file extension and "mmm" is a dash-separated string of model names.
#'
#' @export
#'
modelComparisons.Characteristics.Fisheries<-function(
                                         models,
                                         fleets="all",
                                         selyears="all",
                                         retyears="all",
                                         output_format=c("word_document","pdf_document"),
                                         output_dir=getwd(),
                                         rmd=system.file("rmd/modelComparisons.EstimatedCharacteristics.Fisheries.Rmd",package="rCompTCMs"),
                                         docx_styles=system.file("rmd/StylesForRmdDocs.docx",package="wtsUtilities"),
                                         pdf_styles=system.file("rmd/StylesForRmdPDFs.sty",package="wtsUtilities"),
                                         verbose=FALSE,
                                         clean=FALSE){
  nms<-names(models);
  mmm<-paste0(nms,collapse="-");
  mmv<-paste0(nms,collapse=" vs ");
  output_format<-output_format[1];
  output_options<-NULL;

  #get base folder enclosing rmd file
  rmd<-normalizePath(rmd);
  bsf<-dirname(rmd);

  if(output_format=="word_document") {
    doc_type<-"word";
    ext<-"docx";
    output_options<-list(reference_docx=docx_styles);
  } else if(output_format=="pdf_document")  {
    doc_type<-"pdf";
    ext<-"pdf";
    output_options<-list(includes=list(in_header=pdf_styles));
  }
  output_file<-paste0("ModelComparisons.FisheryCharacteristics.",mmm,".",ext);
  title<-paste0("Model Comparisons: Fishery Characteristics -- ",mmv);
  cat("Rendering to '",file.path(output_dir,output_file),"'\n",sep="")
  cat("Title: '",title,"'\n",sep='')
  cat("Base RMD folder \n\t'",bsf,"'\n",sep="");

  rmarkdown::render(rmd,
                    output_format=output_format,
                    output_file=output_file,
                    output_dir=output_dir,
                    intermediates_dir=output_dir,
                    output_options=output_options,
                    params=list(title=title,
                                Models=models,
                                fleets=fleets,
                                selyears=selyears,
                                retyears=retyears,
                                verbose=verbose,
                                doc_type=doc_type),
                    clean=clean);
}

