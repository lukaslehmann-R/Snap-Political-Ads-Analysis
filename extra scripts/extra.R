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


<style>
  /* General Page Styling */
  body {
    background-color: black;
    color: white; /* Set all text to white */
      font-family: 'Futura', sans-serif; /* Futura font */
  }

/* Customize code blocks */
  pre, pre:not([class]) {
    background-color: #333333; /* Dark grey background for code blocks */
      color: white; /* White text in code blocks */
  }

/* Hyperlink Styling */
  a {
    color: #00ffff; /* Bright cyan blue for hyperlinks */
  }

a:hover {
  color: #1e90ff; /* Slightly darker blue on hover */
}

/* DataTable Customization */
  table.dataTable {
    background-color: #333333;  /* Dark grey table background */
      color: white;  /* White text */
  }

table.dataTable thead th {
  background-color: #444444; /* Slightly darker grey for headers */
    color: white; /* White header text */
}

table.dataTable tbody tr {
  background-color: #333333;  /* Dark grey rows */
    color: white;  /* White text */
}

table.dataTable tbody tr:hover {
  background-color: #555555;  /* Lighter grey on hover */
}

.dataTables_wrapper .dataTables_paginate .paginate_button {
  color: white !important;  /* White pagination text */
    background-color: #333333 !important;  /* Dark grey pagination background */
}

.dataTables_wrapper .dataTables_paginate .paginate_button:hover {
  background-color: #444444 !important;  /* Lighter grey on hover */
    color: white !important;
}

/* Floating Table of Contents (ToC) Styling */
  /* The ToC uses Tocify by default in R Markdown for floating ToC */
  
  /* Sidebar container */
  .tocify-wrapper {
    background-color: #54B4D3 !important; /* Choose a color from your palette */
      color: white !important; /* White text */
      font-family: 'Futura', sans-serif !important; /* Futura font */
      padding: 15px;
    border-radius: 5px;
  }

/* ToC header */
  .tocify-header {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
    color: white !important;
  }

/* ToC links */
  .tocify-item {
    color: white !important; /* ToC links */
      font-size: 16px;
    margin: 5px 0;
  }

/* ToC links on hover */
  .tocify-item:hover {
    color: #80FFDB !important; /* Bright blue on hover */
      background-color: rgba(255, 255, 255, 0.1); /* Slightly lighter background on hover */
      border-radius: 3px;
  }

/* Active ToC link */
  .tocify-item.tocify-focus {
    background-color: #7400B8 !important; /* Active section background */
      color: white !important; /* Active section text */
      border-radius: 3px;
  }

/* Ensure the ToC is above other elements */
  .tocify-wrapper {
    z-index: 1000;
  }

/* Adjust ToC position and width */
  .tocify-wrapper {
    width: 250px; /* Adjust as needed */
  }

/* Responsive adjustments */
  @media (max-width: 768px) {
    .tocify-wrapper {
      display: none; /* Hide ToC on smaller screens */
    }
  }
</style> 
  
  
  
  
  ---
  title: "Snapchat Political Ads Analysis"
author: "Lukas Lehmann"
date: "2024-09-27"
output:
  html_document:
  toc: true                # Enable Table of Contents
toc_depth: 3            # Include headings up to level 3
toc_float:              # Enable floating ToC
  collapsed: false      # Expanded by default
smooth_scroll: true   # Smooth scrolling
df_print: paged         # Paginate data frames
number_sections: false  # Disable section numbering
highlight: tango        # Syntax highlighting style
self_contained: true    # Embed all resources
---
  
  
  # Create a ggplot bar chart with custom text in the tooltip
  b <- ggplot(zip_harris_sum, aes(x = reorder(state, -zip_spend_total),
                                  y = zip_spend_total,
                                  text = paste("State: ", state,
                                               "<br>Total Spend: $", comma(zip_spend_total)))) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Total Spend by Zip",
       x = "State",
       y = "Total Spend ($)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 10, face = "bold"),  # Rotate x-axis labels for readability
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"))

# Convert to interactive plotly object with custom tooltip
ggplotly(b, tooltip = "text")


# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
zip_targeting_geo <- zip_targeting %>%
  mutate(location_data = map(postal_codes_included, ~ reverse_zipcode(.x)))%>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  select(postal_codes_included, total_spend, latitude, longitude, state)



# # Step 1: Summarize total spending by zip code
# zip_targeting <- zip_targeted_harris_long %>%
#   group_by(postal_codes_included) %>%
#   summarize(total_spend = sum(spend_on_zip))
# 
# # Step 2: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
# # Correctly apply reverse_zipcode to each zip code
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
# # Step 2: Create an interactive scatter map using plotly with fixed marker size
# map_plot <- plot_ly(data = zip_targeting_geo,
#                     type = 'scattergeo',
#                     locationmode = 'USA-states',
#                     lon = ~longitude,
#                     lat = ~latitude,
#                     text = ~paste("Zip Code: ", postal_codes_included,
#                                   "<br>State: ", state,
#                                   "<br>Total Spend: $", scales::comma(total_spend)),
#                     marker = list(size = 6,  # Set a fixed marker size for all points
#                                   color = '#154fd7', opacity = 0.8, line = list(width = 0))) %>%
#   layout(title = "Total Ad Spend by Zip Code",
#          geo = list(scope = 'usa',
#                     projection = list(type = 'albers usa'),
#                     showland = TRUE,
#                     landcolor = '#333333',  # Dark grey land color
#                     subunitwidth = 1,
#                     countrywidth = 1,
#                     subunitcolor = 'white',  # White borders between states
#                     countrycolor = 'white',  # White border for the country
#                     bgcolor = '#000000',  # Black background for the map
#                     lakecolor = '#1c1c1c',  # Dark grey for lakes and water bodies
#                     showlakes = TRUE),
#          paper_bgcolor = '#333333',  # Dark grey background for the entire plot
#          plot_bgcolor = '#333333',  # Dark grey background for the plot
#          title = list(text = "Total Ad Spend by Zip Code", font = list(color = 'white', size = 16)),  # White title
#          font = list(color = 'white'))  # White text for other labels
# 
# # Step 3: Display the map
# map_plot


# # Create the leaflet map with dark tiles and blue circles
# leaflet(zip_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "#154fd7", fillOpacity = 0.8,
#     color = "#154fd7", weight = 1, radius = 50000,  # Blue circles
#     popup = ~paste("State: ", state, "<br>Total Spending: ", format_spending(total_spend))
#   ) %>%
#   addLegend(
#     pal = pal, values = log1p(zip_targeting_geo$total_spend),
#     title = "Total Spending by Zip",
#     opacity = 0.9, position = "bottomright"
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)
# 
# # Create the leaflet map with dark tiles and blue circles
# leaflet(zip_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "#154fd7", fillOpacity = 0.4,
#     color = "#154fd7", weight = 1, radius = 20000,  # Blue circles
#     popup = ~paste("State: ", state, "<br>Total Spending: ", format_spending(total_spend))
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)  # Center the map over the US with appropriate zoom




# Create the leaflet map with dark tiles, blue circles, and state boundaries
# leaflet(zip_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "#154fd7", fillOpacity = 0.8,
#     color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
#     popup = ~paste("State: ", state, "<br>Total Spending: ", format_spending(total_spend))
#   ) %>%
#   addPolygons(
#     data = states, color = "white", weight = 1, smoothFactor = 0.5,  # White state boundaries
#     fillOpacity = 0,  # No fill, just borders
#     highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)  # Center the map over the US with appropriate zoom

# Create the leaflet map with dark tiles, blue circles, and state boundaries
leaflet(zip_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = 0.8,
    color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
    # Ensure that the column names and formatting are correct
    popup = ~paste("State: ", state, "<br>Total Spending: $", scales::comma(total_spend))
  ) %>%
  addPolygons(
    data = states, color = "white", weight = 1, smoothFactor = 0.5,  # White state boundaries
    fillOpacity = 0,  # No fill, just borders
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)  # Center the map over the US with appropriate zoom

# # Create a simple leaflet map with dark tiles and basic popup
# leaflet(zip_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "#154fd7", fillOpacity = 0.8,
#     color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
#     popup = ~paste("Zip Code: ", postal_codes_included)  # Simple test popup
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)  # Center the map over the US with appropriate zoom
# 
# # Test with state field in the popup
# leaflet(zip_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "#154fd7", fillOpacity = 0.8,
#     color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
#     popup = ~paste("Zip Code: ", postal_codes_included, "<br>State: ", state)  # Test with zip code + state
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)


# Test with state and total_spend in the popup
leaflet(zip_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = 0.8,
    color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
    popup = ~paste("Zip Code: ", postal_codes_included, 
                   "<br>State: ", state, 
                   "<br>Total Spending: $", scales::comma(total_spend))  # Add total spend
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

# Create the leaflet map with dark tiles, blue circles, and state boundaries
leaflet(zip_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%  # Dark theme map tiles
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = 0.8,
    color = "#154fd7", weight = 1, radius = 20000,  # Smaller blue circles
    popup = ~paste("Zip Code: ", postal_codes_included, 
                   "<br>State: ", state, 
                   "<br>Total Spending: $", scales::comma(total_spend))  # Popup showing all three
  ) %>%
  addPolygons(
    data = states, color = "white", weight = 1, smoothFactor = 0.5,  # White state boundaries
    fillOpacity = 0,  # No fill, just borders
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)  # Center the map over the US with appropriate zoom



<style>
  /* General Page Styling */
  
  body {
    background-color: black;
    color: white;
    font-family: 'Avenir', sans-serif; /* Avenir font */
  }

/* Floating Table of Contents Styling */
  .tocify {
    background-color: black !important;  /* Black background */
      border: 2px solid white;  /* White trim around the ToC */
      padding: 10px;
    border-radius: 5px;
    color: white;  /* Ensure text inside ToC is white */
  }

/* Ensure the ToC links are styled */
  .tocify .tocify-item {
    color: white !important;  /* White text for ToC links */
      background:black;
    text-decoration: none;  /* No underline on links */
      transition:all 250ms ease-out;
  }

/* Hover effect for ToC links */
  .tocify .tocify-item:hover {
    color: white !important;  /* Blue color on hover */
      background-color: #154fd7;  /* Slightly lighter background on hover */
      border-radius: 3px;
  }

/* Active/Focused ToC link styling */
  .tocify .tocify-item.tocify-focus {
    color: #154fd7 !important;  /* Blue color for the active section */
      background-color: rgba(255, 255, 255, 0.2);  /* Slightly lighter background */
      border-radius: 3px;
  }

/* Keep visited links white */
  .tocify .tocify-item:visited {
    color: white !important;
  }

/* Set the DataTable background and text color */
  table.dataTable {
    background-color: #333333;  /* Dark grey background */
      color: white;  /* White text */
  }

/* Set the header text to white */
  table.dataTable thead th {
    background-color: #444444; /* Slightly darker grey for headers */
      color: white; /* White header text */
  }

/* Set the body text to white */
  table.dataTable tbody td {
    color: white;  /* White text in table body */
  }

/* Customize hover color for rows */
  table.dataTable tbody tr:hover {
    background-color: #555555;  /* Lighter grey on hover */
  }

/* Set pagination buttons to white */
  .dataTables_wrapper .dataTables_paginate .paginate_button {
    color: white !important;  /* White pagination text */
      background-color: #333333 !important;  /* Dark grey pagination background */
  }

/* Pagination button hover effect */
  .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
    background-color: #444444 !important;  /* Lighter grey on hover */
      color: white !important;
  }

/* Adjust search box and info text to be white */
  .dataTables_wrapper .dataTables_filter input,
.dataTables_wrapper .dataTables_length select,
.dataTables_wrapper .dataTables_info {
  color: white;
  background-color: #333333;
}

/* Adjust search box border color */
  .dataTables_wrapper .dataTables_filter input {
    border: 1px solid #555555;
  }


</style>
  
  
  # # Step 3: Pivot the data longer for plotting
  # combined_harris_sum_long <- combined_harris_sum %>%
  #   pivot_longer(cols = c(zip_spend, untargeted_state_spend, total_state_spend),
  #                names_to = "spend_type",
  #                values_to = "total_spend")
  # 
  # # Step 4: Create a plotly bar chart with the correct ordering
  # c <- ggplot(combined_harris_sum_long, aes(x = state, y = total_spend, fill = spend_type,
  #                                           text = paste("State: ", state,
#                                                        "<br>Spend Type: ", spend_type,
#                                                        "<br>Total Spend: $", scales::comma(total_spend)))) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(title = "Total Spend by State and Spend Type",
#        x = "State",
#        y = "Total Spend ($)") +
#   scale_fill_manual(values = c("#154fd7", "#80FFDB", "white")) +  # Use custom blue color palette for the bars
#   theme_minimal() +
#   theme(
#     panel.background = element_rect(fill = "#333333", color = NA),  # Dark grey background
#     plot.background = element_rect(fill = "#333333", color = NA),  # Dark grey plot background
#     text = element_text(family = "Avenir", color = "white"),  # White text with Futura font
#     plot.title = element_text(size = 16, face = "bold", color = "white"),  # White title text
#     axis.title.x = element_text(face = "bold", color = "white"),  # White x-axis label
#     axis.title.y = element_text(face = "bold", color = "white"),  # White y-axis label
#     axis.text.x = element_text(angle = 45, hjust = 1, size = 10, face = "bold", color = "white"),  # White x-axis tick labels
#     axis.text.y = element_text(size = 10, face = "bold", color = "white"),  # White y-axis tick labels
#     panel.grid.major = element_line(color = "#555555"),  # Light grey grid lines
#     panel.grid.minor = element_line(color = "#555555")   # Light grey minor grid lines
#   )
# 
# # Step 5: Convert to interactive plotly chart
# ggplotly(c, tooltip = "text")


# Step 4: Create a plotly bar chart with the correct ordering
c <- ggplot(combined_harris_sum_long, aes(x = state, y = total_spend, fill = spend_type,
                                          text = paste("State: ", state,
                                                       "<br>Spend Type: ", spend_type,
                                                       "<br>Total Spend: $", scales::comma(total_spend)))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Total Spend by State and Spend Type",
       x = "State",
       y = "Total Spend ($)") +
  scale_fill_manual(values = c("#154fd7", "#80FFDB", "white"), 
                    labels = c("Total", "Untargeted", "Zipcode-specific")) +  # Custom fill for the bars and legend
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "#333333", color = NA),  # Dark grey background
    plot.background = element_rect(fill = "#333333", color = NA),  # Dark grey plot background
    text = element_text(family = "Avenir", color = "white"),  # White text with Futura font
    plot.title = element_text(size = 16, face = "bold", color = "white"),  # White title text
    axis.title.x = element_text(face = "bold", color = "white"),  # White x-axis label
    axis.title.y = element_text(face = "bold", color = "white"),  # White y-axis label
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10, face = "bold", color = "white"),  # White x-axis tick labels
    axis.text.y = element_text(size = 10, face = "bold", color = "white"),  # White y-axis tick labels
    panel.grid.major = element_line(color = "#555555"),  # Light grey grid lines
    panel.grid.minor = element_line(color = "#555555")   # Light grey minor grid lines
  )

# Step 5: Convert to interactive plotly chart
ggplotly(c, tooltip = "text")



# # Reshape the data into a long format for easier plotting with ggplot
# topic_long <- topic_counts %>%
#   pivot_longer(cols = c(total_spend, total_impressions), names_to = "metric", values_to = "value")
# 
# 
# # Step 4: Create a plotly bar chart with the correct ordering and legend title
# d <- ggplot(topic_long, aes(x = topic, y = value, fill = metric,
#                                           text = paste("Topic: ", topic,
#                                                        "<br>Metric Type: ", metric,
#                                                        "<br>Value: $", scales::comma(value)))) +
#   geom_bar(stat = "identity", position = "dodge") +
#   labs(title = "Total Spend and Impressions by Topic",
#        x = "Topic",
#        y = "Value",
#        fill = "Metric Type") +  # Custom legend title
#   scale_fill_manual(values = c("#154fd7", "#80FFDB"), 
#                     labels = c("Total Spend", "Total Impressions")) +  # Custom fill for the bars and legend labels
#   theme_minimal() +
#   theme(
#     panel.background = element_rect(fill = "#333333", color = NA),  # Dark grey background
#     plot.background = element_rect(fill = "#333333", color = NA),  # Dark grey plot background
#     text = element_text(family = "Avenir", color = "white"),  # White text with Futura font
#     plot.title = element_text(size = 16, face = "bold", color = "white"),  # White title text
#     axis.title.x = element_text(face = "bold", color = "white"),  # White x-axis label
#     axis.title.y = element_text(face = "bold", color = "white"),  # White y-axis label
#     axis.text.x = element_text(angle = 45, hjust = 1, size = 10, face = "bold", color = "white"),  # White x-axis tick labels
#     axis.text.y = element_text(size = 10, face = "bold", color = "white"),  # White y-axis tick labels
#     panel.grid.major = element_line(color = "#555555"),  # Light grey grid lines
#     panel.grid.minor = element_line(color = "#555555")   # Light grey minor grid lines
#   )
# 
# # Convert to interactive plotly chart
# plotly_chart <- ggplotly(d, tooltip = "text") %>%
#   layout(
#     yaxis = list(tickformat = "$,.0f")  # Format y-axis with dollar sign and commas
#   )
# 
# # Display the chart
# plotly_chart




# ################
# 
# library(plotly)
# 
# # Create the plotly object with dodged bars
# fig <- plot_ly()
# 
# # Add trace for total spend on the primary y-axis
# fig <- fig %>% 
#   add_trace(
#     x = ~topic_counts$topic, 
#     y = ~topic_counts$total_spend, 
#     name = "Total Spend", 
#     type = "bar", 
#     marker = list(color = '#154fd7'), 
#     yaxis = "y",
#     offset = -0.2,  # Shift bars to the left
#     width = 0.4     # Make bars thinner
#   )
# 
# # Add trace for total impressions on the secondary y-axis
# fig <- fig %>% 
#   add_trace(
#     x = ~topic_counts$topic, 
#     y = ~topic_counts$total_impressions, 
#     name = "Total Impressions", 
#     type = "bar", 
#     marker = list(color = '#80FFDB'), 
#     yaxis = "y2",
#     offset = 0.2,   # Shift bars to the right
#     width = 0.4     # Make bars thinner
#   )
# 
# # Define the secondary axis for total impressions
# ay <- list(
#   title = "<b>Total Impressions</b>",
#   overlaying = "y",
#   side = "right",
#   tickfont = list(color = "#80FFDB"),
#   showgrid = FALSE
# )
# 
# # Set the layout with titles and the secondary axis
# fig <- fig %>% layout(
#   title = "Total Spend and Impressions by Topic",
#   xaxis = list(title = "Topic"),
#   yaxis = list(title = "<b>Total Spend ($)</b>", tickformat = "$,.0f", tickfont = list(color = "#154fd7")),
#   yaxis2 = ay,
#   barmode = "overlay",  # This ensures bars don't stack
#   bargap = 0.2,
#   plot_bgcolor = '#333333',
#   paper_bgcolor = '#333333',
#   font = list(color = "white"),
#   legend = list(title = list(text = "Metric Type"))
# )
# 
# # Display the interactive plotly chart
# fig

######

# First, sort the data frame by total_spend in descending order
topic_counts <- topic_counts[order(topic_counts$total_spend, decreasing = TRUE), ]

# Arrange the data in descending order of total_spend
topic_counts <- topic_counts %>%
  arrange(desc(total_spend))

# Create the plotly object with dodged bars
fig <- plot_ly()

# Add trace for total spend on the primary y-axis
fig <- fig %>% 
  add_trace(
    x = ~topic_counts$topic, 
    y = ~topic_counts$total_spend, 
    name = "Total Spend", 
    type = "bar", 
    marker = list(color = '#154fd7'), 
    yaxis = "y",
    offset = -0.2,
    width = 0.4
  )

# Add trace for total impressions on the secondary y-axis
fig <- fig %>% 
  add_trace(
    x = ~topic_counts$topic, 
    y = ~topic_counts$total_impressions, 
    name = "Total Impressions", 
    type = "bar", 
    marker = list(color = '#80FFDB'), 
    yaxis = "y2",
    offset = 0.2,
    width = 0.4
  )

# Define the secondary axis for total impressions
ay <- list(
  title = "<b>Total Impressions</b>",
  overlaying = "y",
  side = "right",
  tickfont = list(color = "#80FFDB"),
  showgrid = FALSE
)

# Set the layout with titles and the secondary axis
fig <- fig %>% layout(
  title = "Total Spend and Impressions by Topic",
  xaxis = list(title = "Topic"),
  yaxis = list(title = "<b>Total Spend ($)</b>", tickformat = "$,.0f", tickfont = list(color = "#154fd7")),
  yaxis2 = ay,
  barmode = "overlay",
  bargap = 0.2,
  plot_bgcolor = '#333333',
  paper_bgcolor = '#333333',
  font = list(color = "white"),
  legend = list(
    title = list(text = "Metric Type"),
    x = 1.15,  # Move legend further to the right
    y = 1,     # Keep legend at the top
    xanchor = "left"  # Anchor legend on its left side
  )
)

# Display the interactive plotly chart
fig



# # Create a dataframe with the count of each topic in the 'topic' column
# topic_counts <- data.frame(
#   topic = topics,
#   count = sapply(topics, function(t) {
#     sum(str_detect(harris_ads_categorized_no_na$topic, regex(t, ignore_case = TRUE)))
#   }), 
#   row.names = NULL
# )






#### Oct 24

# ```{r content zipcodes, out.width="100%", fig.height=4}
# 
# # Add a 'reproductive' column based on the presence of the word 'reproductive' in any case
# repro_targeting <- zip_targeted_harris_long %>%
#   left_join(creative_cat, by = "creative_properties") %>%
#   mutate(reproductive = ifelse(grepl("reproductive", topic, ignore.case = TRUE), 1, 0)) %>%
#   filter(reproductive == 1) %>%
#   group_by(postal_codes_included) %>%
#   summarize(total_spend = sum(spend_on_zip))
# 
# # Ensure zip codes are in the correct format (5-digit strings)
# repro_targeting <- repro_targeting %>%
#   mutate(postal_codes_included = as.character(postal_codes_included))
# 
# # Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
# repro_targeting_geo <- repro_targeting %>%
#   mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
#   filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
#   mutate(
#     latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
#     longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
#     state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
#   ) %>%
#   select(postal_codes_included, total_spend, latitude, longitude, state)
# 
# # Custom function to format spending values
# format_spending <- function(x) {
#   scales::dollar_format()(x)
# }
# 
# # Summarize total spending by zip
# repro_spending <- repro_targeting_geo %>%
#   group_by(state) %>%
#   summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column
# 
# # Replace NA values with 0 for states with no data
# repro_spending$total_spending[is.na(repro_spending$total_spending)] <- 0
# #
# # Get US state boundaries
# states <- map("state", fill = TRUE, plot = FALSE)
# 
# # Define a color palette using a single blue color
# pal_color <- colorNumeric(palette = "pink", domain = log1p(zip_spending$total_spending))
# 
# # Define a function for opacity based on spending amount
# pal_opacity <- scales::rescale(log1p(repro_spending$total_spending), to = c(0.2, 1))
# 
# # Create the leaflet map
# leaflet(repro_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%
#   addPolygons(
#     data = states, color = "white", weight = 1,
#     fillOpacity = 0,
#     highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
#   ) %>%
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "pink", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
#     color = "pink", weight = 1, radius = 15000,
#     popup = ~paste("Zip Code: ", postal_codes_included,
#                    "<br>State: ", state,
#                    "<br>Total Spending: $", scales::comma(total_spend)),
#     popupOptions = popupOptions(closeOnClick = TRUE)
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)
# 
# 
# ```


# ```{r content zipcodes, out.width="100%", fig.height=4}
# #
# # # Add a 'reproductive' column based on the presence of the word 'reproductive' in any case
# # topics_targeting <- zip_targeted_harris_long %>%
# #   left_join(creative_cat, by = "creative_properties")
# #   # mutate(reproductive = ifelse(grepl("immigration", topic, ignore.case = TRUE), 1, 0)) %>%
# #   # filter(reproductive == 1)
# #
# unique(topics_targeting$topic)
# 
# # Add a 'reproductive' column based on the presence of the word 'reproductive' in any case
# repro_targeting <- zip_targeted_harris_long %>%
#   left_join(creative_cat, by = "creative_properties") %>%
#   mutate(reproductive = ifelse(grepl("reproductive", topic, ignore.case = TRUE), 1, 0)) %>%
#   filter(reproductive == 1) %>%
#   group_by(postal_codes_included) %>%
#   summarize(total_spend = sum(spend_on_zip))
# 
# # Ensure zip codes are in the correct format (5-digit strings)
# repro_targeting <- repro_targeting %>%
#   mutate(postal_codes_included = as.character(postal_codes_included))
# 
# # Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
# repro_targeting_geo <- repro_targeting %>%
#   mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
#   filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
#   mutate(
#     latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
#     longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
#     state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
#   ) %>%
#   select(postal_codes_included, total_spend, latitude, longitude, state)
# 
# # Custom function to format spending values
# format_spending <- function(x) {
#   scales::dollar_format()(x)
# }
# 
# # Summarize total spending by zip
# repro_spending <- repro_targeting_geo %>%
#   group_by(state) %>%
#   summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column
# 
# # Replace NA values with 0 for states with no data
# repro_spending$total_spending[is.na(repro_spending$total_spending)] <- 0
# #
# # Get US state boundaries
# states <- map("state", fill = TRUE, plot = FALSE)
# 
# # Define a color palette using a single blue color
# pal_color <- colorNumeric(palette = "red", domain = log1p(zip_spending$total_spending))
# 
# # Define a function for opacity based on spending amount
# pal_opacity <- scales::rescale(log1p(repro_spending$total_spending), to = c(0.2, 1))
# 
# # Create the leaflet map
# leaflet(repro_targeting_geo) %>%
#   addProviderTiles("CartoDB.DarkMatter") %>%
#   addPolygons(
#     data = states, color = "white", weight = 1,
#     fillOpacity = 0,
#     highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
#   ) %>%
#   addCircles(
#     lng = ~longitude, lat = ~latitude,
#     fillColor = "red", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
#     color = "red", weight = 1, radius = 15000,
#     popup = ~paste("Zip Code: ", postal_codes_included,
#                    "<br>State: ", state,
#                    "<br>Total Spending: $", scales::comma(total_spend)),
#     popupOptions = popupOptions(closeOnClick = TRUE)
#   ) %>%
#   setView(lng = -96, lat = 37.8, zoom = 4)
# 
# 
# ```










####### tabs of subject specific



## Reproductive

```{r reproductive, out.width="100%", fig.height=4.5}
topics_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties")

# unique(topics_targeting$topic)
# Add a 'reproductive' column based on the presence of the word 'reproductive' in any case
reproductive_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(reproductive = ifelse(grepl("reproductive", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(reproductive == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
reproductive_targeting <- reproductive_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
reproductive_targeting_geo <- reproductive_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state),  # Extract state abbreviati
    topic = "Reproductive") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
reproductive_spending <- reproductive_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
reproductive_spending$total_spending[is.na(reproductive_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(reproductive_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(reproductive_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Economy

```{r economy, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'economy' column based on the presence of the word 'economy' in any case
economy_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(economy = ifelse(grepl("economy", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(economy == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
economy_targeting <- economy_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
economy_targeting_geo <- economy_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state),  # Extract state abbreviation
    topic = "Economy") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
economy_spending <- economy_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
economy_spending$total_spending[is.na(economy_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(economy_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(economy_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Foreign Policy

```{r foreign_policy, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'foreign_policy' column based on the presence of the word 'foreign_policy' in any case
foreign_policy_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(foreign_policy = ifelse(grepl("foreign policy", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(foreign_policy == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
foreign_policy_targeting <- foreign_policy_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
foreign_policy_targeting_geo <- foreign_policy_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state),  # Extract state abbreviation
    topic = "Foreign Policy") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
foreign_policy_spending <- foreign_policy_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
foreign_policy_spending$total_spending[is.na(foreign_policy_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(foreign_policy_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(foreign_policy_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Project 2025

```{r project_2025, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'project_2025' column based on the presence of the word 'project_2025' in any case
project_2025_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(project_2025 = ifelse(grepl("Project 2025", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(project_2025 == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
project_2025_targeting <- project_2025_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
project_2025_targeting_geo <- project_2025_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state),  # Extract state abbreviation
    topic = "Project 2025") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
project_2025_spending <- project_2025_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
project_2025_spending$total_spending[is.na(project_2025_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(project_2025_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(project_2025_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Healthcare

```{r healthcare, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'healthcare' column based on the presence of the word 'healthcare' in any case
healthcare_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(healthcare = ifelse(grepl("Healthcare", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(healthcare == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
healthcare_targeting <- healthcare_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
healthcare_targeting_geo <- healthcare_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  mutate(topic = "Healthcare") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
healthcare_spending <- healthcare_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
healthcare_spending$total_spending[is.na(healthcare_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(healthcare_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(healthcare_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Personal

```{r personal, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'personal' column based on the presence of the word 'personal' in any case
personal_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(personal = ifelse(grepl("personal", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(personal == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
personal_targeting <- personal_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
personal_targeting_geo <- personal_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  mutate(topic = "Personal") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
personal_spending <- personal_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
personal_spending$total_spending[is.na(personal_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(personal_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(personal_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Tax

```{r tax, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'tax' column based on the presence of the word 'tax' in any case
tax_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(tax = ifelse(grepl("tax", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(tax == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
tax_targeting <- tax_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
tax_targeting_geo <- tax_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  mutate(topic = "Tax") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
tax_spending <- tax_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
tax_spending$total_spending[is.na(tax_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(tax_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(tax_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Hate

```{r hate, out.width="100%", fig.height=4.5}
# unique(topics_targeting$topic)
# Add a 'hate' column based on the presence of the word 'hate' in any case
hate_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(hate = ifelse(grepl("hate", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(hate == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
hate_targeting <- hate_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
hate_targeting_geo <- hate_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  mutate(topic = "Hate") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
hate_spending <- hate_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
hate_spending$total_spending[is.na(hate_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(hate_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(hate_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)

```

## Immigration

```{r immigration, out.width="100%", fig.height=4.5}


# unique(topics_targeting$topic)
# Add a 'immigration' column based on the presence of the word 'immigration' in any case
immigration_targeting <- zip_targeted_harris_long %>%
  left_join(creative_cat, by = "creative_properties") %>%
  mutate(immigration = ifelse(grepl("immigration", topic, ignore.case = TRUE), 1, 0)) %>%
  filter(immigration == 1) %>%
  group_by(postal_codes_included) %>%
  summarize(total_spend = sum(spend_on_zip))

# Ensure zip codes are in the correct format (5-digit strings)
immigration_targeting <- immigration_targeting %>%
  mutate(postal_codes_included = as.character(postal_codes_included))

# Step 1: Use purrr::map_dfr to get latitude, longitude, and state for each zip code
immigration_targeting_geo <- immigration_targeting %>%
  mutate(location_data = purrr::map(postal_codes_included, ~ reverse_zipcode(.x))) %>%
  filter(!map_lgl(location_data, is.null)) %>%  # Remove rows with missing locations
  mutate(
    latitude = map_dbl(location_data, ~ .x$lat),  # Extract latitude
    longitude = map_dbl(location_data, ~ .x$lng),  # Extract longitude
    state = map_chr(location_data, ~ .x$state)  # Extract state abbreviation
  ) %>%
  mutate(topic = "Immigration") %>%
  select(postal_codes_included, total_spend, latitude, longitude, state, topic)

# Custom function to format spending values
format_spending <- function(x) {
  scales::dollar_format()(x)
}

# Summarize total spending by zip
immigration_spending <- immigration_targeting_geo %>%
  group_by(state) %>%
  summarise(total_spending = sum(total_spend, na.rm = TRUE))  # Ensure you're using the correct column

# Replace NA values with 0 for states with no data
immigration_spending$total_spending[is.na(immigration_spending$total_spending)] <- 0
#
# Get US state boundaries
states <- map("state", fill = TRUE, plot = FALSE)

# Define a color palette using a single blue color
pal_color <- colorNumeric(palette = "#154fd7", domain = log1p(zip_spending$total_spending))

# Define a function for opacity based on spending amount
pal_opacity <- scales::rescale(log1p(immigration_spending$total_spending), to = c(0.2, 1))

# Create the leaflet map
leaflet(immigration_targeting_geo) %>%
  addProviderTiles("CartoDB.DarkMatter") %>%
  addPolygons(
    data = states, color = "white", weight = 1,
    fillOpacity = 0,
    highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)
  ) %>%
  addCircles(
    lng = ~longitude, lat = ~latitude,
    fillColor = "#154fd7", fillOpacity = ~pal_opacity,  # Adjust opacity dynamically
    color = "#154fd7", weight = 1, radius = 15000,
    popup = ~paste("Zip Code: ", postal_codes_included,
                   "State: ", state,
                   "Total Spending: $", scales::comma(total_spend)),
    popupOptions = popupOptions(closeOnClick = TRUE)
  ) %>%
  setView(lng = -96, lat = 37.8, zoom = 4)


```







gitcreds::gitcreds_set()
