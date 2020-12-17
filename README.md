Optimizing conversion rate is likely the most common work of a data scientist, and rightfully so. The data revolution has a lot to do with the fact that now we are able to collect all sorts of data about people who buy something on our site as well as people who don't. This gives us a tremendous opportunity to understand what's working well (and potentially scale it even further) and what's not working well (and fix it).
### The goal of this challenge is to build a model that predicts conversion rate and, based on the model, come up with ideas to improve revenue.
We have data about users who hit our site: whether they converted or not as well as some of their characteristics such as their country, the marketing channel, their age, whether they are repeat users and the number of pages visited during that session (as a proxy for site activity/time spent on site).
Data (conversion_data.csv) Columns:

country : user country based on the IP address
age : user age. Self-reported at sign-in step
new_user : whether the user created the account during this session or had already an account and simply came back to the site
source : marketing channel source
Ads: came to the site by clicking on an advertisement SEO: came to the site by clicking on search results
Direct: came to the site by directly typing the URL on the browser total_pages_visited: number of total pages visited during the session. This is a proxy for time spent on site and engagement during the session.
converted: this is our label. 1 means they converted within the session, 0 means they left without buying anything. The company goal is to increase conversion rate: # conversions
/ total sessions.

### Example

head(conversion_data, 1)

#### Field	       Value	                 Description
country	             UK	          the user is based in the UK
age	                 25	            the user is 25 yr old
new_user	           1	        she created her account during this session
source	            Ads	       she came to the site by clicking on an ad
total_pages_visited	 1	         she visited just 1 page during that session
converted	           0	        this user did not buy during this session.
                               These are the users whose behavior we want to change!
