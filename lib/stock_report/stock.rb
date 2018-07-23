class StockReport::Stock

  attr_accessor :symbol, :quantity, :price

  def initialize(symbol)
    @symbol = symbol
  end
end
