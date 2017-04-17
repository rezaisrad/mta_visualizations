library(gtfsr)
library(magrittr)
library(dplyr)

set_api_key()

feedlist_df <- get_feedlist() %>%
  filter(grepl('NYC Subway GTFS', t, ignore.case= TRUE))

NYC <- import_gtfs(feedlist_df$url_d)

routes <- NYC[['routes_df']] %>%
  slice(which(grepl('a|b', route_id, ignore.case=TRUE))) %>%
  '$'('route_id')

# take the NYC `gtfs` object and map routes. includes stops by default.
NYC %>% map_gtfs(route_ids = routes)

# gtfs will plot ALL shapes for a given route_ids. These can be reduced using the `service_ids` option.
ids <- NYC$trips_df %>%
  select(route_id, service_id, shape_id) %>%
  distinct() %>%
  filter(route_id %in% routes)
ids %>% head(5) # see all unique combos of ids
#> # A tibble: 5 <U+00D7> 3
#>   route_id   service_id shape_id
#>      <chr>        <chr>    <chr>
#> 1        A B20161106WKD  A..N43R
#> 2        A B20161106WKD  A..S43R
#> 3        A B20161106WKD  A..N85R
#> 4        A B20161106WKD  A..N54R
#> 5        A B20161106WKD  A..N65R

# lets map just the the first row
route_ids <- ids$route_id[1]
service_ids <- ids$service_id[1]
shape_ids <- ids$shape_id[1]

# lets map the specific data with some other options enabled.
NYC %>%
  map_gtfs(route_ids = route_ids,
           service_ids = service_ids,
           shape_ids = shape_ids,
           route_colors = 'green', # set the route color
           stop_details = TRUE, # get more stop details on click
           route_opacity = .5) # change the route opacity