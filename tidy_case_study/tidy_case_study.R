library(MASS)
library(stringr)
library(dplyr)
library(ggplot2)
library(xtable)

# change this to your working directory
setwd("/Users/kota/Dropbox/R_projects/piecemealR/tidy_case_study")

# --------------------------------------
#   Data arrangement
# --------------------------------------

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

# 
# deaths <- readRDS("deaths.rds")
# 
# ok <- subset(deaths, yod == 2008 & mod != 0 & dod != 0)
# # generate a latex table for the a sample of 15 rows
# xtable(ok[c(1, 1:14 * 2000), c("yod", "mod", "dod", "hod", "cod")],"raw.tex")
# 
# codes <- read.csv("icd-main.csv")
# codes$disease <- sapply(codes$disease,
#                         # insert line change "\n" for every 30 characters
#                         function(x) str_c(strwrap(x, width = 30), collapse = "\n"))
# names(codes)[1] <- "cod"  # rename the first variable to "cod"
# codes <- codes[!duplicated(codes$cod), ]  # eliminate duplication of rows
# 
# # Strictly speaking, the 2008 data should be used, but it is nearly identical.
# deaths08 <- deaths %>% filter(yod == 2008, mod != 0, dod != 0)
# table(deaths$yod)
# 
# save(deaths, codes, file = "tidy_case_study.RData")

# --------------------------------------
#   Rewrite starts here
# --------------------------------------

load("tidy_case_study.RData")

# ---- Display overall hourly deaths ----

deaths %>%
  filter(!is.na(hod)) %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line()

# see help file for comma
deaths %>%
  filter(!is.na(hod)) %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line() +
  labs(x = "Hour of day", y = "Number of deaths" ) +
  scale_y_continuous("Number of deaths", labels = scales::comma)
ggsave("overall.png", width = 10, height = 6)


# minor difference
deaths08 %>%
  filter(!is.na(hod)) %>%
  group_by(hod) %>%
  summarise(nobs = n()) %>%
  ggplot(aes(x = hod, y = nobs)) + geom_line()



# ---- Count deaths per hour, per disease ----
deaths_cod_hod <- deaths %>%
  group_by(cod, hod) %>%
  filter(!is.na(hod)) %>%
  summarise( nobs = n() ) %>%
  left_join(codes, by = "cod")

cod_hod_prop <- deaths_cod_hod %>%
  group_by(cod) %>%
  mutate( prop = nobs / sum(nobs) )


# ----  Compare to overall abundance ----
overall_freq <- cod_hod_prop %>%
  # Note: grouping by hod to get the overal trend for each hour
  group_by(hod) %>%
  summarise( freq_all = sum(nobs) ) %>%
  ungroup() %>%
  mutate( prop_all = freq_all/sum(freq_all) )

master_hod <- left_join(cod_hod_prop, overall_freq, by = "hod")


# ---- Pick better subset of rows to show ----

table_C <- master_hod %>%
  filter(cod %in% c("I21", "N18", "E84", "B16") & hod >= 8 & hod <= 12)

table_C %>%
  # MASS package has its own select() function
  # to specify a function from a particular package, use ::
  dplyr::select(hod, cod, disease, nobs, prop, freq_all, prop_all) %>%
  arrange(hod) %>%
  filter(hod %in% c(8, 9, 10, 11), !(hod==11 & cod=="N18"))


devi_cod <- master_hod %>%
  group_by(cod) %>%
  summarise(
    n = sum(nobs),
    dist = mean((prop - prop_all)^2)
  ) %>%
  filter(n > 50)


# ---- Find outliers ----
devi_cod %>%
  ggplot(aes(x = n, y = dist)) + geom_point()
ggsave("n-dist-raw.png", width = 6, height = 6)


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
ggsave("n-dist-log.png", width = 6, height = 6)

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

# ## Alternatively
# devi_cod$resid <- devi_cod %>%
#   do({
#     y <- log(.$dist)
#     x1 <- log(.$n)
#     use <- (!is.na(y) & !is.na(x1))
#     rlt <- rep(NA, length(y))
#     rlt[use] <- rlm(y ~ x1) %>% residuals()
#     data.frame(rlt)   # returns the residual of same length as y
#   }) %>% unlist()

devi_cod %>%
  ggplot(aes(x = n, y = resid)) +
  geom_hline(yintercept = 1.5, colour = "grey50") +
  scale_x_log10() +
  geom_point()
ggsave("n-dist-resid.png", width = 6, height = 6)


unusual <- devi_cod %>% filter(resid > 1.5)
hod_unusual_big <- left_join(master_hod, unusual, by = "cod") %>%
  filter(n > 350)
hod_unusual_sml<- left_join(master_hod, unusual, by = "cod") %>%
  filter(n <= 350)


# ---- Visualise unusual causes of death ----

hod_unusual_big %>%
ggplot(aes(x = hod, y = prop)) +
  geom_line() +
  geom_line(aes(y = prop_all), data = overall_freq, colour = "grey50") +
  facet_wrap(~ disease, ncol = 3)
# ggsave("unusual-big.png", width = 8, height = 6)

# # the following reproduces a plot with a different data frame
# last_plot() %+% hod_unusual_sml

# or simply repeat the command
hod_unusual_sml %>%
  ggplot(aes(x = hod, y = prop)) +
  geom_line() +
  geom_line(aes(y = prop_all), data = overall_freq, colour = "grey50") +
  facet_wrap(~ disease, ncol = 3)
ggsave("unusual-sml.png", width = 8, height = 4)


