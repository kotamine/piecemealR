library(MASS)
library(stringr)
library(dplyr)
library(ggplot2)


# change this to your working directory
setwd("/Users/kota/Dropbox/R_projects/piecemealR/tidy_case_study")

# if (!file.exists("deaths.rds")) {
#   src <- "https://github.com/hadley/mexico-mortality/raw/master/deaths/deaths08.csv.bz2"
#   #ile.download(src, "deaths.csv.bz2", quiet = TRUE)
#   download.file(src, "deaths.csv.bz2", quiet = TRUE)
#
#   deaths <- read.csv("deaths08.csv.bz2")
#   unlink("deaths08.csv.bz2")
#   deaths$hod[deaths$hod == 99] <- NA
#   deaths$hod[deaths$hod == 24] <- 0
#   deaths$hod[deaths$hod == 0] <- NA
#   deaths$hod <- as.integer(deaths$hod)
#   deaths <- arrange(deaths, yod, mod, dod, hod, cod)
#   deaths <- deaths[c("yod", "mod", "dod", "hod", "cod")]
#
#   saveRDS(deaths, "deaths.rds")
# }


deaths <- readRDS("deaths.rds")

ok <- subset(deaths, yod == 2008 & mod != 0 & dod != 0)
# generate a latex table for the a sample of 15 rows
xtable(ok[c(1, 1:14 * 2000), c("yod", "mod", "dod", "hod", "cod")],"raw.tex")

codes <- read.csv("icd-main.csv")
codes$disease <- sapply(codes$disease,
                        # insert line change "\n" for every 30 characters
                        function(x) str_c(strwrap(x, width = 30), collapse = "\n"))
names(codes)[1] <- "cod"  # rename the first variable to "cod"
codes <- codes[!duplicated(codes$cod), ]  # eliminate duplication of rows

# Strictly speaking, the 2008 data should be used, but it is nearly identical.
deaths08 <- deaths %>% filter(yod == 2008, mod != 0, dod != 0)
table(deaths$yod)

# Display overall hourly deaths
# hod_all <- subset(count(deaths, "hod"), !is.na(hod))
# qplot(hod, freq, data = hod_all, geom = "line") +
#   scale_y_continuous("Number of deaths", labels = function(x) format(x, big.mark = ",")) +
#   xlab("Hour of day")
# ggsave("overall.pdf", width = 10, height = 6)


# Rewrite:
deaths %>%
  filter(!is.na(hod)) %>%
  ungroup() %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line()

# see help file for comma
deaths %>%
  filter(!is.na(hod)) %>%
  ungroup() %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line() +
  labs(x = "Hour of day", y = "Number of deaths" ) +
  scale_y_continuous("Number of deaths", labels = scales::comma)

# minor difference
deaths08 %>%
  filter(!is.na(hod)) %>%
  ungroup() %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line()



# Count deaths per hour, per disease
#
# hod2 <- count(deaths, c("cod", "hod"))
# hod2 <- subset(hod2, !is.na(hod))
# hod2 <- join(hod2, codes)
# hod2 <- ddply(hod2, "cod", transform, prop = freq / sum(freq))

deaths_cod_hod <- deaths %>%
  group_by(cod, hod) %>%
  filter(!is.na(hod)) %>%
  summarise( nobs = n() ) %>%
  left_join(codes, by = "cod")

#  hod2 <- ddply(deaths_cod_hod, "cod", transform, prop = nobs / sum(nobs))


cod_hod_prop <- deaths_cod_hod %>%
  group_by(cod) %>%
  mutate( prop = nobs / sum(nobs) )

cod_hod_prop$prop %>% summary()  # This is correct

## When loading both plyr and dplyr above code gets messed up.
library(plyr)
cod_hod_prop <- deaths_cod_hod %>%
  group_by(cod) %>%
  mutate( prop = nobs / sum(nobs) )

cod_hod_prop$prop %>% summary()  #  This is incorrect



# --------------------- stop here -----------------------------------------
# ! Restart R

library(nycflights13)
library(dplyr)

carrier_dest <- flights %>% group_by(carrier, dest) %>%
  summarise( nobs = n())

dest_prop <- carrier_dest %>% group_by(carrier) %>%
  mutate( prop = nobs/sum(nobs) )

summary(dest_prop$prop)


library(plyr)

#  n()  cannot be used
carrier_dest2 <-  count(flights, c("carrier","dest"))

dest_prop2 <- carrier_dest2 %>% group_by(carrier) %>%
  mutate( prop = freq/sum(freq) )

summary(dest_prop2$prop)  # incorrect

carrier_sum <- count(carrier_dest2, "carrier")
colnames(carrier_sum)
colnames(carrier_sum)[2] <- "freq_sum"
carrier_dest2 <- join(carrier_dest2,carrier_sum)

carrier_dest2$freq2 <- carrier_dest2$freq/carrier_dest2$freq_sum
summary(carrier_dest2$freq2)  # correct




# ------------------------------------------------------------------------

# Compare to overall abundance
# overall <- ddply(hod2, "hod", summarise, freq_all = sum(nobs))
# overall <- mutate(overall, prop_all = freq_all / sum(freq_all))
#
# hod2 <- join(overall, hod2, by = "hod")
#

overall_freq <- cod_hod_prop %>%
  ungroup %>%
  group_by(hod) %>%
  summarise( freq_all = sum(nobs) ) %>%
  ungroup() %>%
  mutate( prop_all = freq_all/sum(freq_all) )

cod_hod_prop_freq <- left_join(cod_hod_prop, overall_freq, by = "hod")


# Pick better subset of rows to show
# cods <- join(arrange(count(deaths, "cod"), desc(freq)), codes)
# mutate(tail(subset(cods, freq > 100), 30), disease = substr(disease, 1, 30))
#
# hod3 <- subset(hod2, cod %in% c("I21", "N18", "E84", "B16") & hod >= 8 & hod <= 12)[1:15, c("hod", "cod", "disease", "nobs", "prop", "freq_all", "prop_all")]
# xtable(hod3[c("hod", "cod", "nobs")], "counts.tex")
# xtable(hod3[c("disease")], "counts-disease.tex")
# xtable(hod3[5], "counts-prop.tex")
# xtable(hod3[6:7], "counts-all.tex")


table_C <- cod_hod_prop_freq %>%
  filter(cod %in% c("I21", "N18", "E84", "B16") & hod >= 8 & hod <= 12)

table_16 <- table_C %>%
  # MASS package has its own select() function
  # to specify a function from a particular package, use ::
  dplyr::select(hod, cod, disease, nobs, prop, freq_all, prop_all) %>%
  arrange(hod) %>%
  filter(hod %in% c(8, 9, 10, 11), !(hod==11 & cod=="N18"))

devi_cod <- cod_hod_prop_freq %>%
  group_by(cod) %>%
  summarise(
    n = sum(nobs),
    dist = mean((prop - prop_all)^2)
  ) %>%
  filter(n > 50)


# devi <- ddply(hod2, "cod", summarise, n = sum(freq),
#   dist = mean((prop - prop_all)^2))
# devi <- subset(devi, n > 50)

# Find outliers
devi_cod %>%
  ggplot(aes(x = n, y = dist)) + geom_point()


devi_cod %>%
  ggplot(aes(x = n, y = dist)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

devi_cod %>%
  ggplot(aes(x = n, y = dist)) +
  scale_x_log10(labels = scales::comma) +
  scale_y_log10(labels = scales::comma) +
  geom_point() +
  geom_smooth(method = "rlm", se = FALSE)


my_rlm_resid <- function(y, x1) {
  use <- (!is.na(y) & !is.na(x1))
  rlt <- rep(NA, length(y))
  rlt[use] <- rlm(y ~ x1) %>% residuals()
  rlt   # returns the residual of same length as y
}

devi_cod <- devi_cod %>%
  mutate(
    resid = my_rlm_resid(log(dist),log(n))
  )

devi_cod %>%
  ggplot(aes(x = n, y = resid)) +
  geom_hline(yintercept = 1.5, colour = "grey50") +
  scale_x_log10() +
  geom_point()


unusual <- devi_cod %>% filter(resid > 1.5)
hod_unusual_big <- left_join(cod_hod_prop_freq, unusual, by = "cod") %>%
  filter(n > 350)
hod_unusual_sml<- left_join(cod_hod_prop_freq, unusual, by = "cod") %>%
  filter(n <= 350)

hod_unusual_big %>%
  ggplot(aes(x = hod, y = prop)) +
  geom_line(aes(y = prop_all), data = overall_freq, colour = "grey50") +
  geom_line() +
  facet_wrap(~ disease, ncol = 3)

# the following reproduces a plot with a different data frame
last_plot() %+% hod_unusual_sml

# or simply repeat the command
hod_unusual_sml %>%
  ggplot(aes(x = hod, y = prop)) +
  geom_line(aes(y = prop_all), data = overall_freq, colour = "grey50") +
  geom_line() +
  facet_wrap(~ disease, ncol = 3)



