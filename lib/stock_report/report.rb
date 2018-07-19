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
    puts "Start"
    list = File.read("./report.txt").split("$")
    list.each do |stock|
      stock.chomp!
      url = "https://www.nasdaq.com/symbol/#{stock}"
      doc = Nokogiri::HTML(open(url))
      price = doc.css("div.qwidget-dollar").text
      price.delete!("*")
      puts "#{stock} - #{price}"
    end
  end
end