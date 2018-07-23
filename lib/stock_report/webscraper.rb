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
end
