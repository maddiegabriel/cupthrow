require_relative 'Coin'
require_relative 'Die'

# RandomizerFactory class - creates new Randomizers (Coin/Die objects) using given params
class RandomizerFactory
   def create_die(sides, colour)
      # call Die constructor
      @die = Die.new(sides, colour)
   end

   def create_coin(denomination)
      # call Coin constructor
      @coin = Coin.new(denomination)
   end
end