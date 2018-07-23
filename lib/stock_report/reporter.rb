class StockReport::Reporter

  def check
    puts "Please enter the stock symbol of the stock you wish to check on."
    input = ""
    input = gets.strip
    price = StockReport::WebScraper.new("https://www.nasdaq.com/symbol/#{input}").price_lookup
    if price == ""
      puts "Stock not found."
    else
      puts self.report
    end
  end

  def list
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
    puts "The total value of your portfolio is $#{total}"
  end

  def add
    puts "Please enter the symbol of the stock you wish to add."
    input = ""
    input = gets.strip
    url = "https://www.nasdaq.com/symbol/#{input}"
    doc = Nokogiri::HTML(open(url))
    price = doc.css("div.qwidget-dollar").text
    price.delete!("*")
    if price == ""
      puts "Stock not found."
    else
      duplicate = false
      report = Nokogiri::XML(File.open("report.xml"))
      stocks = report.xpath("//stock")
      report.xpath("//stocks/stock/symbol").each do |symbol|
        if symbol.text.upcase == input.upcase
          duplicate = true
        end
      end
      if duplicate == false
        puts "Please enter the quantity of #{input.upcase} you wish to add."
        quantity = gets.strip.to_i
        while quantity == 0
          puts "Please enter a quantity of stocks that is 1 or more."
          quantity = gets.strip.to_i
        end
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
      else
        puts "This stock is already in your portfolio. If quantity has changed please remove the stock then add again with updated quantity."
      end
    end
  end

  def remove
    puts "Please enter the symbol of the stock you wish to remove."
    input = gets.strip
    report = Nokogiri::XML(File.open("report.xml"))
    report.xpath("//stocks/stock").each do |stock|
      stock.children.each do |child|
        if child.text.upcase == input.upcase
          stock.remove
        end
      end
    end
    File.write("report.xml", report.to_xml)
  end

  def clear
    report = Nokogiri::XML(File.open("report.xml"))
    report.xpath("//stocks/stock").each do |stock|
      stock.remove
    end
    File.write("report.xml", report.to_xml)
  end

end
