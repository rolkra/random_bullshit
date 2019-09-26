# packages
library(tidyverse)
library(stringr)
library(explore)

# reproducible random numbers
set.seed(123)

# number of observations
nobs <- 10000

# random data
data <- tibble(
  id = format(100100100:(100100100+nobs-1), 
              big.mark = "|", 
              decimal.mark = ","),
  age = sample(16:95, nobs, replace = TRUE),
  gender = sample(c("M","F"), nobs, replace = TRUE),
  handset = sample(c("Apple","Android"), prob = c(0.4,0.6), nobs, replace = TRUE),
  eye_color = sample(c("blue","green","brown"), nobs, replace = TRUE),
  iq = trunc(rnorm(nobs, mean = 100, sd = 20)),
  # starsign = sample(c("Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
  #                     "Libra", "Scorpio", "Sagittarius", "Capricorn", 
  #                     "Aquarius", "Pisces"), nobs, replace = TRUE),
  starsign = sample(c("Widder", "Stier", "Zwilling", "Krebs", "Loewe",
                      "Jungfrau", "Waage", "Skorpion", "Schütze", 
                      "Steinbock", "Wassermann","Fische"), nobs, replace = TRUE),
  pet = sample(c("dog","cat","bird", "snake","spider","rat","no"), 
               prob = c(0.2,0.2,0.1,0.05,0.05,0.05,0.35),
               nobs, replace = TRUE),
  tshirt_size = sample(c("1_S","2_M","3_L","4_XL"), nobs, replace = TRUE),
  shoe_size = trunc(rnorm(nobs, mean = 43, sd = 3)),
  showers_daily = sample(0:1, nobs, prob = c(0.2, 0.8), replace = TRUE),

  favorite_pizza = sample(c("Margaritha", "Carciofi","Pepperoni", "Hawai", "Quattro Statgioni", "Provenciale"), nobs, replace = TRUE),
  favorite_icecream = sample(c("Vanilla", "Chocolate","Strawberry", "Lemon", "Cookie", "Hazelnut","Apple"), 
                             prob=c(0.3,0.2,0.2,0.1,0.1,0.05,0.05),
                             nobs, replace = TRUE),
  loves_beatles = sample(0:1, nobs, prob = c(0.1,0.9), replace = TRUE),
  loves_sushi = sample(0:1, nobs, prob = c(0.7, 0.3), replace = TRUE),
  loves_coffee = sample(0:1, nobs, prob = c(0.3, 0.7), replace = TRUE),
  loves_shopping = sample(0:1, nobs, prob = c(0.3, 0.7), replace = TRUE),
  loves_sport = sample(0:1, nobs, prob = c(0.5, 0.5), replace = TRUE)
  )

# not random correlations
random01 <- runif(nobs)
data$loves_shopping <- ifelse(data$gender == "F", 1, 0)
data$loves_beatles <- ifelse(data$loves_beatles + data$age/50 * random01>= 1, 1, 0)
data$favorite_icecream <- ifelse(data$handset == "Apple" & data$favorite_pizza == "Hawai" & random01 > 0.2, "Hazelnut", data$favorite_icecream)

# explore data
explore(data)

# export data 
data %>% write_delim(path = "C:/R/data_fake.csv", 
                     delim = ";")
# clean id
data %>% 
  mutate(id_clean = str_replace_all(id, "[^0-9]", "")) %>% 
  View()
