class StockReport::WebScraper
  attr_accessor :url, :doc
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(open(self.url))
  end

  def price_lookup
    price = self.doc.css("div.qwidget-dollar").text
    price = price.delete!("*")
    return price
  end

  def name_lookup
    name = self.doc.css("h1").text
    name = name.split(" (")[0]
    return name
  end



  def most_active
    counter = 0
    list = []
    while counter < 20
      symbol = self.doc.css("[id = two_column_main_content_MostActiveByShareVolume_tickerwidget_MostActiveByShareVolume_#{counter}_summaryquotes_#{counter}]").text
      puts "#{counter + 1}. #{symbol}"
      list << symbol
      counter += 1
    end
    return list
  end
end
