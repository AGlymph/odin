def stock_picker(prices)
  max_profit = 0 
  max_profit_days = [0,1]
  prices.each_index do |index|
    sell_day = index
    sell_day_price = prices[index]
    prices[...index].each_index do |i|
      buy_day = index - i - 1
      buy_day_price = prices[buy_day]
      profit = sell_day_price - buy_day_price
      if  profit > max_profit
        max_profit = profit
        max_profit_days = [buy_day, sell_day]
      end
    end
  end
  max_profit_days
end
p stock_picker([17,3,6,9,15,8,6,1,10])