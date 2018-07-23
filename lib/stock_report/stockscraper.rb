class StockReport::StockScraper
  attr_accessor :file, :doc
  @@file = "report.xml"
  def initialize
    @doc = Nokogiri::XML(open(@@file))
  end

  def list_stocks
    list = []
    stocks = self.doc.xpath("//stock")
    stocks.each do |info|
      stock = StockReport::Stock.new(info.xpath("symbol").text.upcase)
      stock.quantity = info.xpath("quantity").text.to_f
      stock.price = StockReport::WebScraper.new("https://www.nasdaq.com/symbol/#{stock.symbol}").price_lookup
      list << stock
    end
    return list
  end

  def self.save(list)
    File.write(@@file, list.to_xml)
  end
end
