


#' Get a set of standard colours as hex codes
#'
#' @param col_category 
#'
#' @return
#' @export
#'
#' @examples
#' 
#' col_vector = get_colours(col_group="BL-genetic")
#' 
get_colours = function(col_category,
                       col_group,
                       return_format="vector"){
  if(!missing(col_category)){
    these_codes = full_codes %>% 
      dplyr::filter(category==col_category)
  }else{
    these_codes = full_codes 
  }
  
  if(!missing(col_group)){
    these_codes = these_codes %>% 
      dplyr::filter(group==col_group)
  }
  
  if(return_format=="vector"){
    these_codes_v = pull(these_codes,Code)
    names(these_codes_v) = pull(these_codes,Name)
    return(these_codes_v)
  }
  return(these_codes)
}

#' Show all the colour codes in a table
#'
#' @return
#' @export
#'
#' @examples
#' show_colours()
#' show_colours(col_category = "subgroup")
#' show_colours(col_group = "BL-genetic")
show_colours = function(col_category,col_group){
  if(!missing(col_category)){
    these_codes = full_codes %>% 
      dplyr::filter(category==col_category)
  }else{
    these_codes = full_codes 
  }
  
  if(!missing(col_group)){
    these_codes = these_codes %>% 
      dplyr::filter(group==col_group)
  }
  these_codes %>% 
    kbl() %>%
    kable_styling(full_width = T) %>%
    column_spec(1, color = "white",
                background = these_codes$Code) %>% 
    column_spec(2, color = "white",
                background = these_codes$Code)
}

#' Summarize all the colour codes in a table after applying some or no filtering criteria
#'
#' @return Nothing
#' @export
#'
#' @examples
#' 
#' summarise_colours()
#' summarise_colours(col_category="subgroup")
#' summarise_colours(col_category="patient")
#' 
#' 
summarise_colours = function(col_category,col_group){
  if(!missing(col_category)){
    these_codes = full_codes %>% 
      dplyr::filter(category==col_category)
  }else{
    these_codes = full_codes 
  }
  
  if(!missing(col_group)){
    these_codes = these_codes %>% 
      dplyr::filter(group==col_group)
  }
  category = group_by(these_codes,category) %>%
    mutate(number_in_category=n()) %>%
    slice_head() %>% 
    dplyr::rename("Example_Name"="Name")
  print(category)
  group = group_by(these_codes,group) %>%
    mutate(number_in_group=n()) %>%
    slice_head() %>% 
    dplyr::rename("Example_Name"="Name")
  print(group)
}
