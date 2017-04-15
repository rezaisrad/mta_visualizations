# Download Turnstile and Fare Data from MTA 
library(curl)
start_date = as.Date("140125",format = "%y%m%d")
end_date = as.Date("170401",format = "%y%m%d")
date = start_date

while(date <= end_date) {
  curl_download(sprintf("http://web.mta.info/developers/data/nyct/turnstile/turnstile_%s.txt", 
                        as.character.Date(date,format = "%y%m%d")), 
                sprintf("turnstile_%s.txt", as.character.Date(date,format = "%y%m%d")))
  curl_download(sprintf("http://web.mta.info/developers/data/nyct/fares/fares_%s.csv", 
                        as.character.Date(date,format = "%y%m%d")), 
                sprintf("fares_%s.txt", as.character.Date(date,format = "%y%m%d")))
  date = date + 7 
}

