# Exploring Ollie's files
# 
library(ncdf4) # to get what's needed from ncdf files

path_to_files <- "./Databse Ollie/"
ID_folders <- dir(path_to_files, pattern = "ID")

x <- 1 # first ID

path_to_trips <- paste0(path_to_files, ID_folders[x], "/")
ID_trips_folders <- dir(path_to_trips)

x_trip <- 1 # first trip for the ID

path_to_ncdf <- paste0(path_to_trips, ID_trips_folders[x_trip], "/netCDF/")
ncdf_name <- dir(path_to_ncdf)

# open netCDF file
nc_file <- nc_open(paste0(path_to_ncdf, ncdf_name))
print(nc_file) # getting all the characteristics of the file

# It seems that lon and lat were mixed up in the netcdf files
Lon <- ncvar_get(nc_file, "Lat")
summary(Lon)
Lat <- ncvar_get(nc_file, "Lon")
summary(Lat)
Time <- ncvar_get(nc_file, "Time")
head(Time) # needs to be fixed
str(Time)
Time_pos <- as.POSIXct(Time, tz="GMT", origin = "1970-01-01 00:00:00")

Pressure <- ncvar_get(nc_file, "Pressure")
head(Pressure)
plot(Pressure)

Pressure_matrix <- t(ncvar_get(nc_file, "Full_matrix"))
nc_close(nc_file)
Pressure_df <- as.data.frame(Pressure_matrix)
colnames(Pressure_df) <- c("Time","Lon","Lat","Pressure_hPa")
str(Pressure_df)
Pressure_df$Time <- as.POSIXct(Pressure_df$Time, tz="GMT", origin = "1970-01-01 00:00:00")
head(Pressure_df$Time)

########
########
# let's check the next trip
# 

x_trip <- 2 # first trip for the ID

path_to_ncdf <- paste0(path_to_trips, ID_trips_folders[x_trip], "/netCDF/")
ncdf_name <- dir(path_to_ncdf)

# open netCDF file
nc_file <- nc_open(paste0(path_to_ncdf, ncdf_name[1]))
print(nc_file) # getting all the characteristics of the file

# It seems that lon and lat were mixed up in the netcdf files
Lon <- ncvar_get(nc_file, "Lat")
summary(Lon)
Lat <- ncvar_get(nc_file, "Lon")
summary(Lat)
Time <- ncvar_get(nc_file, "Time")
head(Time) # needs to be fixed
str(Time)
Time_pos <- as.POSIXct(Time, tz="GMT", origin = "1970-01-01 00:00:00")

Pressure <- ncvar_get(nc_file, "Pressure")
head(Pressure)
plot(Pressure)

Pressure_matrix <- t(ncvar_get(nc_file, "Full_matrix"))
nc_close(nc_file)
Pressure_df <- as.data.frame(Pressure_matrix)
colnames(Pressure_df) <- c("Time","Lon","Lat","Pressure_hPa")
str(Pressure_df)
Pressure_df$Time <- as.POSIXct(Pressure_df$Time, tz="GMT", origin = "1970-01-01 00:00:00")
head(Pressure_df$Time)

# Open PDF file
# # open netCDF file
nc_file <- nc_open(paste0(path_to_ncdf, ncdf_name[2]))
print(nc_file) # getting all the characteristics of the file
Pdf_matrix <- t(ncvar_get(nc_file, "PDF"))

# Open SPL file
# # open netCDF file
nc_file <- nc_open(paste0(path_to_ncdf, ncdf_name[3]))
print(nc_file) # getting all the characteristics of the file
Time <- ncvar_get(nc_file, "UTC timestamp")
head(Time) # needs to be fixed
str(Time)
Time_pos <- as.POSIXct(Time, tz="GMT", origin = "1970-01-01 00:00:00")
head(Time_pos)
Lon <- ncvar_get(nc_file, "Lon")
summary(Lon)
head(Lon)
Lat <- ncvar_get(nc_file, "Lat")
summary(Lat)

SPL_Freq_0.0 <- ncvar_get(nc_file, "SPL_Freq_0.0")
head(SPL_Freq_0.0)
plot(SPL_Freq_0.0 )

# getting the names of the columns
names_var <- names(nc_file$var)
names_var <- names_var[1:(length(names_var)-1)]
SPL_Matrix <- ncvar_get(nc_file, "Full_matrix")
nc_close(nc_file)
SPL_df <- as.data.frame(SPL_Matrix)
colnames(SPL_df) <- c("Time",names_var[2:length(names_var)])
str(SPL_df)
SPL_df$Time <- as.POSIXct(SPL_df$Time, tz="GMT", origin = "1970-01-01 00:00:00")


