
#Glen Canyon trout research - Shiny app development
#read data and join sampling site info to main data

library(ggdist)
library(reshape2)
library(plyr)
library(ggplot2)
library(grid)
library(dplyr)
library(viridis)

setwd("~/R Analyses/Glen Canyon Trout/GCD Shiny App")
rm(list = ls())

GCD_Trout <- read.table("GCD_SexMatData_All_Years.csv", sep=",", header=T, na="")

Glen_sites <- read.table("TRGD_Site_Info.csv", sep =",", header=T, na="")

GCD_Trout_Sites <- merge(x = GCD_Trout, y = Glen_sites, by = "Site", all.x = TRUE)

GCD_Trout_Sites$Dissect_Sex <-factor(GCD_Trout_Sites$Dissect_Sex, levels=c("F","M", "U") )
GCD_Trout_Sites$Site <-factor(GCD_Trout_Sites$Site)
GCD_Trout_Sites$Year <-factor(GCD_Trout_Sites$Year)
GCD_Trout_Sites$Reach.y <-factor(GCD_Trout_Sites$Reach.y, levels=c("1A", "1B", "1C"))
unique(GCD_Trout_Sites$Trip)
GCD_Trout_Sites$Trip <-factor(GCD_Trout_Sites$Trip, levels=c("Oct18", "Feb19", "Apr19", "Nov19", "Jan20"))


temp<-ggplot(GCD_Trout_Sites)+
  geom_point(aes(x = log(ForkLength), y = log(Body_WGT), colour=Dissect_Sex), size =2.5)+
  facet_grid(~Year)+
  xlab("Fork Length (mm)")+ylab("Weight (g)")+
  scale_color_viridis(discrete = TRUE, option = "D")+
  theme_bw()
temp
