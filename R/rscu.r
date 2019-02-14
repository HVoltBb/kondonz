#' Relative synonymous codon usage
#'
#' Calculates the relative synomynous codon usage (RSCU) for each codon.
#'
#' @details The RSCU is calculated for each animo acid coding codon present in the provided codon sequence. When any animo acid is missing from the sequence, each coding codon for that animo acid will have NA returned as their RSCU. The RSCU of stop codons also have NAs in their position as the default setting. To include RSCUs for the stop codons in the returned array, set \emph{stop} as TRUE.
#' @param x a KZsqns object of codon sequence or a list of such objects
#' @param y an optional number denoting the codon table to be used. 0 = standard codon table (default), 2 = vertibrate mitchodrial (See dna2aa for additional options). When an option other than those mentioned above is provided, the standard codon table will be used
#' @param supplementory.info whether supplementory information should be returned. If TRUE, the top 5 and bottom 5 most frequently used codons will be returned in the result; if FALSE, no supplementory information will be returned, and this is the default option
#' @param stop a optional boolean denoting whether the RSCU values for the stop codons should be returned. FALSE: NAs will be returned (default); TRUE: the RSCUs will be returned
#' @return a named list containing a numeric array of RSCUs for each animo acid, an ordered list the top 5 most frequently used codons, and an ordered list of the top 5 least frequently used codons. Or a list of such lists, when \emph{x} is a list of objects
#' @examples
#'
#' @export

rscu <- function(x, y=0, stop = FALSE, supplementory.info = FALSE){
  if(is.list(x)){
    return(lapply(x, rscu_, y, stop, supplementory.info))
  }else{
    return(rscu_(x, y, stop, supplementory.info))
  }
}
