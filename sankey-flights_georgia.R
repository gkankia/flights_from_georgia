library(networkD3)
library(dplyr)

links <- data.frame(
  source=c("Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Tbilisi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Batumi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi", "Kutaisi"), 
  target=c("Istanbul", "Dubai", "Tel-Aviv", "Sharjah", "Kyiv", "Baku","Yerevan", "Doha", "Tehran", "Kuwait", "Munich", "Almaty", "Antalya", "Riga", "Warsaw", "Bahrein", "Aktau", "Athens", "Minsk", "Nursultan", "Riyadh", "Beirut", "Dammam", "Paris", "Urumqi", "Amsterdam", "Barcelona", "Berlin", "Bologna", "Brussels", "Jeddah", "London", "Prague", "Vienna", "Amman", "Ankara", "Bucharest", "Sharm El Sheikh", "Tashkent", "Heraklion", "Malta", "Maribor", "Milas-Bodrum", "Thessaloniki", "Tel Aviv", "Kyiv", "Istanbul", "Minsk", "Yerevan", "Baku", "Amman", "Riyadh", "Nursultan", "Kuwait", "Kharkiv", "Odessa", "Vienna", "Paris", "Berlin", "Dortmund", "Athens", "Budapest", "Eindhoven", "Warsaw", "Brussels", "Larnaca", "Prague", "Copenhagen", "Tallinn", "Basel", "Thessaloniki", "Bari", "Milan", "Rome", "Riga", "Vilnius", "Gdansk", "Katowice", "Krakow", "Poznan", "Wroclaw", "Barcelona", "London"), 
  value=c(59, 29, 28, 22, 22, 28, 19, 17, 15, 9, 9, 8, 8, 7, 7, 6, 5, 5, 7, 5, 5, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 19, 14, 9, 7, 4, 3, 3, 3, 2, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3))

nodes <- data.frame(
  name=c(as.character(links$source), 
         as.character(links$target)) %>% unique()
)

links$IDsource <- match(links$source, nodes$name)-1 
links$IDtarget <- match(links$target, nodes$name)-1

#Europe - #abdda4
#Asia - #fdae61

links$group <- as.factor(c("Istanbul", "Dubai", "Tel-Aviv", "Sharjah", "Kyiv", "Baku","Yerevan", "Doha", "Tehran", "Kuwait", "Munich", "Almaty", "Antalya", "Riga", "Warsaw", "Bahrein", "Aktau", "Athens", "Minsk", "Nursultan", "Riyadh", "Beirut", "Dammam", "Paris", "Urumqi", "Amsterdam", "Barcelona", "Berlin", "Bologna", "Brussels", "Jeddah", "London", "Prague", "Vienna", "Amman", "Ankara", "Bucharest", "Sharm El Sheikh", "Tashkent", "Heraklion", "Malta", "Maribor", "Milas-Bodrum", "Thessaloniki", "Tel Aviv", "Kyiv", "Istanbul", "Minsk", "Yerevan", "Baku", "Amman", "Riyadh", "Nursultan", "Kuwait", "Kharkiv", "Odessa", "Vienna", "Paris", "Berlin", "Dortmund", "Athens", "Budapest", "Eindhoven", "Warsaw", "Brussels", "Larnaca", "Prague", "Copenhagen", "Tallinn", "Basel", "Thessaloniki", "Bari", "Milan", "Rome", "Riga", "Vilnius", "Gdansk", "Katowice", "Krakow", "Poznan", "Wroclaw", "Barcelona", "London"))

my_color <- 'd3.scaleOrdinal() .domain(["Tbilisi", "Batumi", "Kutaisi", "Istanbul", "Dubai", "Tel-Aviv", "Sharjah", "Kyiv", "Baku","Yerevan", "Doha", "Tehran", "Kuwait", "Munich", "Almaty", "Antalya", "Riga", "Warsaw", "Bahrein", "Aktau", "Athens", "Minsk", "Nursultan", "Riyadh", "Beirut", "Dammam", "Paris", "Urumqi", "Amsterdam", "Barcelona", "Berlin", "Bologna", "Brussels", "Jeddah", "London", "Prague", "Vienna", "Amman", "Ankara", "Bucharest", "Sharm El Sheikh", "Tashkent", "Heraklion", "Malta", "Maribor", "Milas-Bodrum", "Thessaloniki", "Kharkiv", "Odessa", "Dortmund", "Budapest", "Eindhoven", "Larnaca", "Copenhagen", "Tallinn", "Basel", "Thessaloniki", "Bari", "Milan", "Rome", "Vilnius", "Gdansk", "Katowice", "Krakow", "Poznan", "Wroclaw"]).range(["#e6f598", "#f4a582", "#66c2a5", "#fdae61", "#fdae61", "#fdae61", "#fdae61", "#abdda4", "#abdda4", "#abdda4", "#fdae61", "#fdae61", "#fdae61", "#abdda4", "#fdae61", "#fdae61", "#abdda4", "#abdda4", "#fdae61", "#fdae61", "#abdda4", "#abdda4", "#fdae61", "#fdae61", "#fdae61", "#fdae61", "#abdda4", "#fdae61", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#fdae61", "#abdda4", "#abdda4", "#abdda4", "#fdae61", "#fdae61", "#abdda4",  "#fdae61", "#fdae61", "#abdda4", "#abdda4", "#abdda4", "#fdae61", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4", "#abdda4"])'

p <- sankeyNetwork(Links = links, Nodes = nodes,
                   Source = "IDsource", Target = "IDtarget",
                   Value = "value", NodeID = "name", colourScale = my_color, LinkGroup = "group",
                   sinksRight=TRUE, fontFamily = "sans-serif", fontSize = 12)
p
