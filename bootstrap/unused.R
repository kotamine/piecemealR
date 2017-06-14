# 
# library(MASS)
# data(oats)
# oats2 <- oats
# names(oats2) = c('block', 'variety', 'nitrogen', 'yield')
# 
# summary(oats2)
# 
# table(oats2$variety)
# table(oats2$block)
# # all three varieties in each block 
# table(oats2$variety, oats2$block) 
# 
# table(oats2$nitrogen)
# # each block contains a single observation of each variety-nitrogen combination
# table(oats2$nitrogen, oats2$variety, oats2$block) 
# 
# lmer(yield ~ variety*nitrogen + (1| block),  data = oats2) %>% summary()
# 
# lmer(yield ~ variety*nitrogen + (1| block/variety),  data = oats2) %>% summary()
# 
# lmer(yield ~ variety + nitrogen + (1| block),  data = oats2) %>% summary()
# lmer(yield ~ variety + nitrogen + (1| block/variety),  data = oats2) %>% summary()
# 
# lmer(yield ~  nitrogen + (1 | block/variety),  data = oats2) %>% summary()
# lm(yield ~  nitrogen + variety + block,  data = oats2) %>% summary()
# lm(yield ~  nitrogen + variety*block,  data = oats2) %>% summary()
# lm(yield ~  nitrogen*variety + variety*block,  data = oats2) %>% summary()
