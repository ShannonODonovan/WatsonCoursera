## SQL Server connection

# library(odbc)
# con <- dbConnect(odbc(),
#                  Driver = "SQL Server",
#                  Server = "mysqlhost",
#                  Database = "mydbname",
#                  UID = "myuser",
#                  PWD = rstudioapi::askForPassword("Database password"),
#                  Port = 1433)

# RODBC requires setting up ODBC connection on PC
# am using Windows auth


install.packages("pacman")
require(pacman) 
pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, 
               ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, 
               stringr, tidyr, RODBC) 


# ================== Make Connection ==================
db_conn <- odbcConnect("SQLServerD", rows_at_time = 1)

# verify connection
if(db_conn == -1) {quit("no", 1)}

## build query USE NO COUNT ON
sql <- "
    SET NOCOUNT ON; 
     
    select * from V2.dbo.Vase_Shape
"

dfShape <- sqlQuery(db_conn, sql, stringsAsFactors = FALSE)

head(dfShape)

# Need a table with frequencies for each category
Shapes <- table(dfShape$ShapeNme)  # Create summary table

head(Shapes)

# BASIC HISTOGRAMS #########################################
plot(Shapes)


# HISTOGRAM BY GROUP #######SMALL MULTIPLES TO COMPARE THESE RANGES

# Put graphs in 3 rows and 1 column
par(mfrow = c(3, 1))



# Restore graphic parameter
par(mfrow=c(1, 1))

# CLEAN UP #################################################

# Clear packages
detach("package:datasets", unload = TRUE)  # For base

# Clear plots
dev.off()  # But only if there IS a plot

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
