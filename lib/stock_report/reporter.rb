class StockReport::Reporter

  def check
    puts "Please enter the stock symbol of the stock you wish to check on."
    input = ""
    input = gets.strip
    price = StockReport::WebScraper.new("https://www.nasdaq.com/symbol/#{input}").price_lookup
    if price == nil
      puts "Stock not found."
    else
      puts price
    end
  end

  def list
    total = 0.0
    list = StockReport::StockScraper.new.list_stocks
    list.each do |stock|
      price = stock.price.delete("$")
      price = (price.to_f * stock.quantity).round(2)
      puts "#{stock.quantity.to_i} of #{stock.symbol.upcase} - $#{price}"
      total += price
    end
    puts "The total value of your portfolio is $#{total.round(2)}"
  end

  def add
    #ASKS FOR STOCK BY SYMBOL AND MAKES SURE IT EXISTS
    puts "Please enter the symbol of the stock you wish to add."
    input = ""
    input = gets.strip
    price = StockReport::WebScraper.new("https://www.nasdaq.com/symbol/#{input}").price_lookup
    if price == nil
      puts "Stock not found."
    #MAKES SURE THIS STOCK IS NOT ALREADY IN REPORT.XML
    else
      duplicate = false
      list = StockReport::StockScraper.new.list_stocks
      list.each do |stock|
        if stock.symbol == input.upcase
          duplicate = true
        end
      end
      #ASKS FOR STOCK QUANTITY
      if duplicate == false
        puts "Please enter the quantity of #{input.upcase} you wish to add."
        quantity = gets.strip.to_i
        while quantity == 0
          puts "Please enter a quantity of stocks that is 1 or more."
          quantity = gets.strip.to_i
        end
        #OPENS A COPY OF REPORT.XML AND CREATES NEW NODE
        new_doc = StockReport::StockScraper.new.doc
        new_stock = Nokogiri::XML::Node.new "stock", new_doc
        new_stock.add_child("<quantity>#{quantity}</quantity>")
        new_stock.add_child("<symbol>#{input}</symbol>")
        #NODE IS ADDED DIFFERENTLY IF REPORT.XML IS EMPTY
        if list.empty?
          new_doc.xpath("//stocks").each do |node|
            node << new_stock
          end
        else
          new_doc.xpath("//stock").after(new_stock)
        end
        #THE NEW REPORT.XML IS SAVED
        puts "#{input.upcase} added to portfolio."
        StockReport::StockScraper.save(new_doc)
      else
        puts "This stock is already in your portfolio. If quantity has changed please remove the stock then add again with updated quantity."
      end
    end
  end

  def remove
    puts "Please enter the symbol of the stock you wish to remove."
    input = gets.strip
    new_doc = StockReport::StockScraper.new.doc
    found = false
    new_doc.xpath("//stocks/stock").each do |stock|
      stock.children.each do |child|
        if child.text.upcase == input.upcase
          stock.remove
          found = true
        end
      end
    end
    if found == true
      puts "#{input.upcase} removed from portfolio."
      StockReport::StockScraper.save(new_doc)
    else
      puts "#{input.upcase} was not found in portfolio. Please double-check entry and try again."
    end
  end

  def clear
    new_doc = StockReport::StockScraper.new.doc
    new_doc.xpath("//stocks/stock").each do |stock|
      stock.remove
    end
    puts "Portfolio Erased."
    StockReport::StockScraper.save(new_doc)
  end

end
