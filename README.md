# README

The application would be executed on standard Rails server with port 3000.

The Member model handles the basic attributes of each member of the social networking platform, which consists of the first/last name of the member, the website URL (original and shorten)
and the member account credentials (username as the combination of the first/last name and URL, with hashed password).

Shortening URL is implemented using the Bitly gem which wraps the public Bitly API for URL shortening.

Each member has single/multiple site content, which consists of the context within his website. The HTML context on the website is grabbed using Open-URI based on the URL and the h1-h3 
headings within are scrapped using Nokogiri.

* Ruby version: 2.4.0 (support for Bitly gem usage)
* Basic unit test cases for models and functional test cases for controllers are provided.
* Incomplete due to time limit: member search function has not been fully implemented as required.
