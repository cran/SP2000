##' @title Search Catalogue of Life China checklist
##' @description Get checklist via species or infraspecies ID.
##' @rdname search_checklist
##' @name search_checklist
##' @param query \code{string} single or more query, see [search_family_id()] and [search_taxon_id()] for more details.
##' @param mc.cores The number of cores to use, i.e. at most how many child processes will be run simultaneously. The option is initialized from environment variable MC_CORES if set. Must be at least one, and parallelization requires at least two cores,see [mclapply()] for details.
##' @return Catalogue of Life China list(s)
##' @author Liuyong Ding
##' @details Visit the website \url{http://sp2000.org.cn/api/document} for more details.
##' @importFrom pbmcapply pbmclapply
##' @importFrom jsonlite fromJSON
##' @examples
##' \dontrun{
##' ##Set your key
##' set_search_key <- "your apiKey"
##'
##' ##Search family IDs via family name
##' familyid <- search_family_id(query = "Anguillidae")
##'
##' ##Search taxon IDs via familyID
##' taxonid <- search_taxon_id(query = familyid$familyIDs,name = "familyID")
##'
##' #Download detailed lists via species or infraspecies ID
##' x <- search_checklist(query = taxonid$taxonIDs)
##' str(x)
##' }
##' @export

search_checklist <- function(query = NULL,mc.cores = 2){
  cat(sprintf("last Update: %s",Sys.Date()),sep = "\n")
  if (.Platform$OS.type == "windows") {
    mc.cores = 1
  }
  if (is_search_key_set()){
  if(length(query) == 1){
    x <- species(query)
  } else {
    x <- pbmclapply(query,species,mc.cores = mc.cores)
  }
  return(x)
  }else {
    cat("*******************************************************************************\n")
    cat("** You need to apply for the apiKey from http://sp2000.org.cn/api/document   ** \n** to run all search_* functions, and then run set_search_key('your apiKey') **")
    cat("\n*******************************************************************************\n")
  }
}

species <- function(query = NULL) {
  if (is_search_key_set()){
  url <- paste0('http://www.sp2000.org.cn/api/taxon/species/taxonID/', query, '/', Sys.getenv("sp2000_apiKey"))
  x <- fromJSON(url,flatten = TRUE)
  x$downloadDate <- as.Date(Sys.time())
  return(x)
  }else {
    cat("You need to apply for the apiKey from http://sp2000.org.cn/api/document \n to run all search_* functions, and then run set_search_key('your apiKey')")
  }
}

