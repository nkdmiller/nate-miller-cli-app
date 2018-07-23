# class StockReport::StockScraper
#   attr_accessor :file, :doc
#
#   def initialize
#     @file = "report.xml"
#     @doc = Nokogiri::XML(open(@file))
#   end
#
#   def list_stocks
#     # list = self.doc.xpath("//stock")
#     # list.each do |stock|
#     #   symbol = stock.xpath("symbol").text
#     #   quantity = stock.xpath("quantity").text.to_f
#     #   url = "https://www.nasdaq.com/symbol/#{symbol}"
#     #   doc = Nokogiri::HTML(open(url))
#     #   price = doc.css("div.qwidget-dollar").text
#     #   price.delete!("*")
#     #   price.delete!("$")
#     #   price = (price.to_f * quantity).round(2)
#     #   puts "#{quantity.to_i} of #{symbol.upcase} - $#{price}"
#     #   total += price
#   end
# end
