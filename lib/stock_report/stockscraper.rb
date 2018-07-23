class StockReport::StockScraper
  attr_accessor :file, :doc

  def initialize
    @file = "report.xml"
    @doc = Nokogiri::XML(open(@file))
  end

  def list_stocks
    list = []
    stocks = self.doc.xpath("//stock")
    stocks.each do |info|
      stock = StockReport::Stock.new(info.xpath("symbol").text)
      stock.quantity = info.xpath("quantity").text.to_f
      stock.price = StockReport::WebScraper.new("https://www.nasdaq.com/symbol/#{stock.symbol}").price_lookup
      list << stock
    end
    return list
  end
end
