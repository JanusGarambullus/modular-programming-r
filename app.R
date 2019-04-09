
## This is the main script that calls on the different submodules
## All of the folders will contain different scripts, intermediate files etc.
## There are 3 submodules: Start, middle and end
## Start will go ahead and import some data and make some basic manipulations
## Middle will pick it up and run some machine learning on it
## End will create a report

library(tidyverse)
library(caret)

# Call all submodules
source("start/start.R")
source("middle/middle.R")
source("end/end.R")

