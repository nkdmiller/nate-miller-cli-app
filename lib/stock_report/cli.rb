require './lib/stock_report/version'
class StockReport::CLI
  def call
    menu
  end
  def menu
    input = ""
    while input != "exit"
      puts "------------------------------------------"
      puts "Welcome to stock report! What can I do for you?"
      puts "------------------------------------------"
      puts "Enter 1 to check the price of a certain stock."
      puts "Enter 2 to list the prices of your stocks."
      puts "Enter 3 to add a new stock to your list."
      puts "Enter 4 to remove a stock from your list."
      puts "Enter 5 to erase your entire list."
      puts "Enter exit to leave the program."
      input = gets.strip
      if input == "1"
        StockReport::Reporter.new.check
      elsif input == "2"
        StockReport::Reporter.new.list
      elsif input == "3"
        StockReport::Reporter.new.add
      elsif input == "4"
        StockReport::Reporter.new.remove
      elsif input == "5"
        StockReport::Reporter.new.clear
      end
    end
  end
end
