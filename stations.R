library(dplyr)
library(data.table)
library(leaflet)
library(googleVis)

stations_data = paste(getwd(),"data","Stations.csv",sep = "/")

stations = fread(input = stations_data, sep = ",")

stations = stations %>%
  mutate(LatLong = paste(`GTFS Latitude`,`GTFS Longitude`, sep=":"))




# Styling/Mapping Each MTA Station
### Leaflet
map_style = "https://api.mapbox.com/styles/v1/rezarad77/cj1p42yjb002f2snfi65ac93c/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoicmV6YXJhZDc3IiwiYSI6ImNqMXAyOHZvMzAwOWczNG1seHY4ZzJzdXcifQ.JwYon0JR4nbIAMC-fsaNyw"

# subway 
# icons <- leaflet::awesomeIcons(
#   icon = 'fa-subway', 
#   iconColor = 'black',
#   library = 'fa'
# )

m = leaflet::leaflet() %>%
  leaflet::addTiles(map_style) %>%
  leaflet::setView(lng = -73.947, lat = 40.706, zoom = 11) %>% 
  leaflet::addPolylines((stations %>%
                          filter(`Daytime Routes` == "M") %>%
                          select(`GTFS Longitude`))[[1]],
                        (stations %>%
                          filter(`Daytime Routes` =="M") %>%
                          select(`GTFS Latitude`))[[1]]
                        )
  # leaflet::addAwesomeMarkers(stations$`GTFS Longitude`,
  #                            stations$`GTFS Latitude`,
  #                            icon = icons,
  #                            label = stations$`Stop Name`)
m



## GoogleVis
# ny_map <- gvisMap(data = stations,
#                   locationvar = "LatLong",
#                   tipvar = "Daytime Routes",
#                   options = list(
#                     dataMode = 'markers',
#                     mapType='normal'
#                   ))
# 
# plot(ny_map)
# 
