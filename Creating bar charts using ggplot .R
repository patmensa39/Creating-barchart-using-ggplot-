# Creating Bar charts in R programming
### make sure to install all the packages below. 
pacman::p_load(datasets, pacman, psych, rio, tidyverse, wesanderson)


### HairEye datasets 
?HairEyeColor
view(HairEyeColor)
glimpse(HairEyeColor)

data <- HairEyeColor %>% as_tibble() %>% # converting to tibbles with rows
  uncount(n) %>%  # converting from the summary values 
  mutate_all(as_factor) %>%  # converting all the variables as factors 
  mutate_all(fct_infreq) %>% # reorders in descending orders
  print()

glimpse(data)
attach(data)

### Generic plot command 
data %>% select(Hair) %>% 
  plot(main = "Bar plot of Hair color", col = wes_palette("BottleRocket1"))

data %>% select(Eye) %>%
  plot(main = "Bar plot of Eye color", col = wes_palette("IsleofDogs1"))

data %>% select(Sex) %>%
  plot(main = "Bar plot of Gender", col = c("red", "blue"))


### Using qplot 
qplot(Hair, data = data)
qplot(Eye, data = data)
qplot(Sex, data = data)


### Using qqplot 
### One step approach
### Hair, plots in 2 different ways 
data %>% ggplot() + geom_bar(aes(x = Hair))
ggplot(data = data,mapping = aes(x = Hair)) + geom_bar()

### Eyes 
data %>% ggplot() + geom_bar(aes(x = Eye))
ggplot(data = data,mapping = aes(x = Eye)) + geom_bar()

### Genger
data %>% ggplot() + geom_bar(aes(x = Sex))
ggplot(data = data,mapping = aes(x = Sex)) + geom_bar()

###Two steps approach 
### 2 different ways 
### Hair
g <- data %>% ggplot(aes(Hair))
g + geom_bar()
### 2nd way 
g<- ggplot(data = data, mapping = aes(x = Hair))
g +geom_bar()




### Eye color 
g <- data %>% ggplot(aes(Eye))
g + geom_bar()
### 2nd way 
g<- ggplot(data = data, mapping = aes(x = Eye))
g +geom_bar()


### Gender 
g <- data %>% ggplot(aes(Sex))
g + geom_bar()
### 2nd way 
g<- ggplot(data = data, mapping = aes(x = Sex))
g +geom_bar()


### Hair, adding options 
g <- data %>% ggplot(aes(Hair))
g + geom_bar(fill = "blue") + 
             theme_minimal() + ### removing the background
             coord_flip() + ## fliping the coordinates 
             labs(
               title = "Hair Color",
               subtitle = "592 Statistics Student",
               caption = "(From HairEyeColor sample dataset)",
               y = "Number of Students",
               x = "Hair color"
             )

### saving the plot

ggsave("philantbarchart.png", width = 12, height = 6, dpi = 300)
ggsave("philantbarchart.pdf", width = 12, height = 6, dpi = 300)

## Grouped 
### side by side bar chart 
data %>% ggplot(aes(Hair, fill = Sex)) + 
  geom_bar(position = position_dodge()) +
  theme(legend.position = "bottom")

ggplot(data = data, mapping = aes(x = Hair, fill = Sex)) +
  geom_bar(position = position_dodge()) +
  theme(legend.position = "top")

## stacked bar chart 
data %>% ggplot(aes(Hair, fill = Sex)) + 
  geom_bar()

ggplot(data = data, mapping = aes(x = Hair, fill = Sex)) +
  geom_bar()

### 100% stacked bar chart 
data %>% ggplot(aes(Hair, fill = Sex)) + 
  geom_bar(position = "fill")

ggplot(data = data, mapping = aes(x = Hair, fill = Sex)) +
  geom_bar(position = "fill")            
