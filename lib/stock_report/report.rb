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
    stocks.each do |stock|
      symbol = stock.xpath("symbol").text
      quantity = stock.xpath("quantity").text.to_f
      url = "https://www.nasdaq.com/symbol/#{symbol}"
      doc = Nokogiri::HTML(open(url))
      price = doc.css("div.qwidget-dollar").text
      price.delete!("*")
      price.delete!("$")
      price = (price.to_f * quantity).round(2)
      puts "#{quantity.to_i} of #{symbol.upcase} - $#{price}"
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
      puts "Please enter the number of #{input.upcase} owned."
      quantity = gets.strip
      report = Nokogiri::XML(File.open("report.xml"))
      stocks = report.xpath("//stock")
      new_stock = Nokogiri::XML::Node.new "stock", report
      new_stock.add_child("<quantity>#{quantity}</quantity>")
      new_stock.add_child("<symbol>#{input}</symbol>")
      if stocks.empty?
        report.xpath("//stocks").each do |node|
          node << new_stock
        end
      else
        report.xpath("//stock").after(new_stock)
      end
      File.write("report.xml", report.to_xml)
    end
  end
end
