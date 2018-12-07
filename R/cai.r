#' Codon adaptation index
#'
#' Calculates the codon adaptation index (CAI) for each codon
#'
#' @param x a char array of codons, for which CAI will be calculated
#' @param ref a named numeric array of relative adaptiveness of each codon from a species-specific reference set of very highly expressed genes. The array should have a length of 64 with 0 filled in at the stop codons. The name of each number is the corresponding char array of codon. For example, "AAA" or "Aaa" represent the same codon. Upper case letters can be mixed with lower case letters.
#' @param ref_spp a char sequence of species name to use. "ecoli" = \emph{Escherichia coli}; "bsubt" = \emph{Bacillus subtilis}; "scere" = \emph{Saccharomyces cerevisiae}. When specified, it overides the value set by \emph{ref}
#' @param y an optional number denoting the codon table to be used. 0 = standard codon table (default), 2 = vertibrate mitchodrial, 3 = ?, 4 = ?. When an option other than those mentioned above is provided, the standard codon table will be used
#' @param threthold a number below which the adaptiveness will be forced to \emph{lower_bound}
#' @param lower_bound a number to which values of adaptiveness below the \emph{threshold} will be forced
#' @return a number denoting the CAI for the provided sequence
#' @details When any reference codon has a relative usage value of zero and the codon sequence to be calculated has such a codon, the CAI for this sequence would be
#' @source
#' The reference set of very highly expressed genes for \emph{E. coli}, \emph{B. subtilis} and \emph{S. cerevisiae} from taken from the C program condonW version 1.4.4 writen by John Peden available at http://codonw.sourceforge.net/. For more information see, the documentation of condonW.
#' @examples
#'
#' @export

cai <- function(x, ref_spp='n', ref, y = 0, threthold = 0.005, lower_bound = 0.005){
  switch(as.character(ref_spp),
                         'ecoli' = {
                           ref = cai_ref$ecoli
                         },
                         'bsubt' = {
                           ref = cai_ref$bsubt
                         },
                         'scere' = {
                           ref = cai_ref$scere
                         },
         'n' = {
           if(class(ref)!='numeric' || length(ref)!=64 || is.null(names(ref))) stop("A named numeric array of length 64 is expected")
         },
                         {
                           stop("Not a valid species name. Options include 'ecoli', 'bsubt' and 'scere'.")
                         })
  cTable = arg_check(x, 'character',y)

  temp = table(cTable[,2])
  exclude = which(cTable[,2] %in% c('*', names(temp)[which(temp==1)]))
  ref[ref<threthold] <- lower_bound
  ref = ref[cTable[-exclude,1]]

  tx = table(x)[-exclude]
  return(exp(crossprod(tx,log(ref))/sum(tx)))

}
