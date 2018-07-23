# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
  CLI class allows for user interactivity. Logic is built into Reporter class.
- [X] Pull data from an external source
  Data is scraped from NASDAQ.com and Report.XML which can be modified in the program. Nokogiri is used to scrape HTML and XML.
- [X] Implement both list and detail views
  Any stock on NASDAQ has data that can be retrieved by the program. The most_active function lists the most active stocks by share value according to NASDAQ.com and the user can retrieve data for item in the list. The list function scrapes data from Report.XML to list the data in the portfolio and NASDAQ.com.
