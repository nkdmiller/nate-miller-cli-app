class StockReport::Report

  def check
    puts "Please enter the stock symbol of the stock you wish to check on."
    input = ""
    input = gets.strip
    url = "https://www.nasdaq.com/symbol/#{input}"
    doc = Nokogiri::HTML(open(url))
    price = doc.css("div.qwidget-dollar").text
    price.delete!("*")
    if price == ""
      puts "Stock not found."
    else
      puts price
    end
  end

  def list
    puts "------------------------------------------"
    total = 0.0
    list = Nokogiri::XML(File.open("report.xml"))
    stocks = list.xpath("//stock")
    symbol = stocks.xpath("symbol").text
    quantity = stocks.xpath("quantity").text.to_i
    stocks.each do |stock|
      symbol = stocks.xpath("symbol").text
      quantity = stocks.xpath("quantity").text.to_f
      url = "https://www.nasdaq.com/symbol/#{symbol}"
      doc = Nokogiri::HTML(open(url))
      price = doc.css("div.qwidget-dollar").text
      price.delete!("*")
      price.delete!("$")
      price = (price.to_f * quantity).round(2)
      puts "#{quantity.to_i} of #{symbol} - $#{price}"
      total += price
    end
    puts "For a total portfolio value of $#{total}"
  end

  def add
    input = ""
    input = gets.strip
    url = "https://www.nasdaq.com/symbol/#{input}"
    doc = Nokogiri::HTML(open(url))
    price = doc.css("div.qwidget-dollar").text
    price.delete!("*")
    if price == ""
      puts "Stock not found."
    else
      open('./report.txt', 'a') { |f|
        f.puts input
      }
    end
  end
end
