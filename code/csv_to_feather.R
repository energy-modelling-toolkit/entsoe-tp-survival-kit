library(feather)
library(glue)
library(dplyr)
library(readr)

args = commandArgs(trailingOnly=TRUE)

filename = args[1]
is_directory = file_test('-d', filename)

if (!is_directory) {
  
  d = read.table(filename, header = TRUE, sep = '\t', fileEncoding = 'UTF-16LE', 
                 stringsAsFactors = FALSE) %>%
    dplyr::filter(AreaTypeCode == 'CTY') %>% # I select only the country data, not interested in bidding zones (BZN) and control areas (CTA)
    select(-YEAR, -MONTH, -DAY, -areacode, -AreaName) %>%
    feather::write_feather(glue('{filename}.feather')) 
} else {
  lf = list.files(path = filename, pattern = glob2rx('*Aggregated*csv'), 
                  full.names = TRUE)
  for (f in lf) {
    read_delim(f, delim = '\t', 
               col_types = 
               cols(
                 DateTime = col_character(), 
                 ResolutionCode = col_character(),
                 AreaCode = col_character(),
                 AreaTypeCode = col_character(),
                 AreaName = col_character(),
                 MapCode = col_character(),
                 ProductionType = col_character(),
                 ActualGenerationOutput = col_double(),
                 ActualConsumption = col_double(),
                 UpdateTime = col_character() 
               )
    ) %>%
               
      dplyr::filter(AreaTypeCode == 'CTY') %>%
      select(-AreaCode, -AreaName) %>%
      feather::write_feather(glue('{f}.feather')) 
  }
}
