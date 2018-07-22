require './lib/stock_report/version'
class StockReport::CLI
  def call
    menu
  end
  def menu
    input = ""
    while input != "exit"
      puts "Welcome to stock report! What can I do for you?"
      puts "------------------------------------------"
      puts "Enter 1 to check the price of a certain stock."
      puts "Enter 2 to list the prices of your stocks."
      puts "Enter 3 to add a new stock to your list."
      puts "Enter 4 to remove a stock from your list."
      puts "Enter exit to leave the program."
      input = gets.strip
      if input == "1"
        StockReport::Report.new.check
      elsif input == "2"
        StockReport::Report.new.list
      elsif input == "3"
        StockReport::Report.new.add
      elsif input == "4"
        StockReport::Report.new.remove
      end
    end
  end
end
