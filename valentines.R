install.packages(c("tidyverse", "ggplot2", "plotly"))
library(tidyverse); library(ggplot2); library(plotly)
spending <- read_csv("historical_spending.csv")
gift_spending <- spending %>%
  pivot_longer(cols = Candy:GiftCards,
               names_to = "Category", values_to = "Spending")
myplot <- ggplot(gift_spending, aes(x = Year, y = Spending)) +
  geom_line(color = "red", linewidth = 1) +
  geom_point(color = "red", size = 2) +
  facet_wrap(~ Category, ncol = 2, labeller = labeller(Category = c(
    Candy = "Candy", Clothing = "Clothing", EveningOut = "Evening Out",
    Flowers = "Flowers", GiftCards = "Gift Cards",
    GreetingCards = "Greeting Cards", Jewelry = "Jewelry"))) +
  scale_x_continuous(breaks = c(2010, 2014, 2018, 2022)) +
  scale_y_continuous(labels = scales::label_dollar()) +
  expand_limits(y = 0) +
  labs(
    title = "Valentine's Day Spending by Gift Category",
    subtitle = "Historical trends to inform next year's inventory planning",
    x = "Year", y = "Average planned spending per person",
    caption = "Source: NRF surveys via Kaggle | 2010–2022") +
  theme_minimal()
ggsave("myplot.png", plot = myplot, width = 10, height = 10, dpi = 300)
print(ggplotly(myplot))