#data-raw/data_download_script.r

#how data is got into rnaturalearth
#reproducible workflow allowing package data to be updated e.g. when there are updates to Natural Earth.
#just by sourcing this script

#one example file in rnaturalearth
#scale 110 and 50 files in rntauralearthdata
#scale 10 files in rntauralearthhires

library(rnaturalearth)

countries10 <- ne_download(scale=10, type='countries', category='cultural')
map_units10 <- ne_download(scale=10, type='map_units', category='cultural')
sovereignty10 <- ne_download(scale=10, type='sovereignty', category='cultural')
states10 <- ne_download(scale=10, type='states', category='cultural')
coastline10 <- ne_download(scale=10, type='coastline', category='physical')


#### todo
#### version numbers, can I check the version number from the VERSION.txt file and save it in the package somewhere ?
#### would want to put that in ne_download()


#to allow same operation on all data objects in the package
data_object_names <- data(package = "rnaturalearthhires")[["results"]][,"Item"]


#### saving data files to correct folder in the package
#this relies on working directory being set to root of the package
# BEWARE circular that it uses list of existing data in package
# new data would have to be added outside of this

#the lines below could be replaced by this dangerous eval(parse(text=)) loop
for (i in 1:length(data_object_names))
{
  data_name <- data_object_names[i]
  #eval(parse(text=paste0("save(",data_name,", file='data/",data_name,".rda'")))
  #this sorts compression
  eval(parse(text=paste0("devtools::use_data(",data_name,", compress='xz', overwrite=TRUE)")))
}
