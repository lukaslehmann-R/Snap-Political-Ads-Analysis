#extra code

# trump_ads <- us_ads %>%
#   filter(str_detect(candidate_ballot_information, "Trump"))
# 
# trump_ads_summary <- trump_ads %>%
#   group_by(paying_advertiser_name) %>%
#   summarize(total_impressions = sum(impressions),
#             total_spend = sum(spend)) %>%
#   arrange(desc(total_spend))
# 
# trump_advertisers <- head(trump_ads$paying_advertiser_name, 7)
# 
# organization_1 <- trump_advertisers[1]
# organization_2 <- trump_advertisers[2]
# organization_3 <- trump_advertisers[3]
# organization_4 <- trump_advertisers[4]
# organization_5 <- trump_advertisers[5]
# organization_6 <- trump_advertisers[6]
# organization_7 <- trump_advertisers[7]
# 
# # Create a list of filtered tables for top 10 spenders
# trump_ads_list <- lapply(trump_advertisers, function(advertiser_name) {
#   us_ads %>%
#     mutate(impressions_per_dollar = impressions/spend) %>%
#     filter(paying_advertiser_name == advertiser_name) %>%
#     select(paying_advertiser_name, spend, impressions, 
#            candidate_ballot_information, creative_url,
#            start_date, end_date) %>%
#     # Convert creative_url to clickable links
#     mutate(creative_url = paste0("<a href='", creative_url, "' target='_blank'>Link</a>"))
# })
# 
# # Name the list elements for easier reference
# names(trump_ads_list) <- trump_advertisers


# # Visualize using ggplot2 and plotly
# p <- ggplot(daily_spending, aes(x = date_range, y = total_daily_spend)) +
#   geom_line(color = "blue", size = 1.2) +
#   labs(title = "Harris for President - Daily Ad Spending",
#        x = "Date",
#        y = "Total Spending ($)") +
#   theme_minimal()
# 
# # Convert to plotly object to enable interactive hover
# ggplotly(p)

p <- ggplot(daily_spending, aes(x = date_range, y = total_daily_spend)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(color = "blue", aes(text = paste("Date: ", date_range, "<br>Daily Spend: $", total_daily_spend)), size = 1.7) +
  labs(title = "Harris for President - Daily Ad Spending",
       x = "Date",
       y = "Total Spending ($)") +
  theme_minimal()

# Convert to plotly with tooltip showing text from geom_point()
ggplotly(p, tooltip = "text")


p <- ggplot(daily_spending, aes(x = date_range, y = total_daily_spend)) +
  geom_line(color = "blue", size = 1.2) +
  geom_point(color = "blue", 
             aes(text = paste("Date: ", date_range, "<br>Daily Spend: $", round(total_daily_spend))), 
             size = 1.7) +
  labs(title = "Harris for President - Daily Ad Spending",
       x = "Date",
       y = "Total Spending ($)") +
  theme_minimal()

# Convert to plotly with tooltip showing text from geom_point()
ggplotly(p, tooltip = "text")



# 
# # Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
# zip_targeting_geo <- zip_targeting %>%
#   mutate(location_data = map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
#   filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
#   mutate(
#     latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
#     longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
#     state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
#   ) %>%
#   select(postal_codes_included, total_spend, latitude, longitude, state)
# 
# # Step 2: Create an interactive scatter map using plotly
# map_plot <- plot_ly(data = zip_targeting_geo, 
#                     type = 'scattergeo', 
#                     locationmode = 'USA-states',
#                     lon = ~longitude, 
#                     lat = ~latitude, 
#                     text = ~paste("Zip Code: ", postal_codes_included, 
#                                   "<br>State: ", state, 
#                                   "<br>Total Spend: $", scales::comma(total_spend)),
#                     marker = list(size = ~sqrt(total_spend) * 2,  # Adjust marker size based on spend
#                                   color = 'royalblue', opacity = 0.7, line = list(width = 0))) %>%
#   layout(title = "Total Ad Spend by Zip Code",
#          geo = list(scope = 'usa',
#                     projection = list(type = 'albers usa'),
#                     showland = TRUE,
#                     landcolor = 'rgb(217, 217, 217)',
#                     subunitwidth = 1,
#                     countrywidth = 1,
#                     subunitcolor = 'rgb(255, 255, 255)',
#                     countrycolor = 'rgb(255, 255, 255)'))
# 
# # Step 3: Display the map
# map_plot

# aug_30_ads <- harris_ads %>%
#   filter(as.Date(start_date) == as.Date("2024-09-10"))

# test <- harris_ads_official %>%
#   select(regions_included, regions_excluded, postal_codes_included, postal_codes_excluded) %>%
#   filter(!is.na(regions_included))
# 
# test <- harris_ads_official %>%
#   select(regions_included, regions_excluded, postal_codes_included, postal_codes_excluded) %>%
#   filter(!is.na(postal_codes_included))
