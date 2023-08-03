

#master tsv file resides in morinlab/LLMPP/
# https://raw.githubusercontent.com/morinlab/LLMPP/main/resources/colours/colour_codes.tsv

full_codes = read_tsv("inst/extdata/colour_codes.tsv") %>% 
  dplyr::filter(is.na(is_alias)) %>% select(-is_alias)


full_codes = full_codes %>% rename("Name"="name","Code"="colour") %>% 
  dplyr::relocate(Name,Code)

usethis::use_data(full_codes,overwrite = T)
