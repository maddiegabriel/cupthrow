require_relative 'Player'
require_relative 'RandomizerFactory'

puts "\n-----------------------------------------------------------------------"
puts "\tCIS*3260 Assignment 1 Testing Script - Maddie Gabriel :)"
puts "-----------------------------------------------------------------------\n\n"

# test template used for each test
def print_test(n, title, purpose, expected, actual)
    expected == actual ? passed = true : passed = false

    puts "\nTEST ##{n} :: #{title}"
    puts "Purpose: #{purpose}"
    puts "Expected Result: #{expected}"
    puts "Actual Result: #{actual}"
    if passed
        str = "Result: test ##{n} PASSED"
        puts("\e[32m#{str}\e[0m")
    else
        str = "Result: test ##{n} FAILED"
        puts("\e[31m#{str}\e[0m")
    end
end

puts "-------------------------------------------------------"
puts "USE CASE #1 :: New player wants to throw a cup of dice"
puts "-------------------------------------------------------\n"

# test #1: create player
player1 = Player.new("Maddie")
expected = "New player with the name \"Maddie\""
actual = "New player with the name \"#{player1.name}\""
print_test(1, "Create a player", "to test the creation of a new player with a specific name", expected, actual)

# test #2: create dice using factory & add them to player's bag
factory = RandomizerFactory.new()
die1 = factory.create_die(6, :red)
die2 = factory.create_die(7, :red)
die3 = factory.create_die(10, :blue)
die4 = factory.create_die(7, :red)
die5 = factory.create_die(7, :yellow)
player1.store(die1)
player1.store(die2)
player1.store(die3)
player1.store(die4)
player1.store(die5)
bag_description = "{ Type = :die, Sides = 6, Colour = red, Sideup =  }
{ Type = :die, Sides = 7, Colour = red, Sideup =  }
{ Type = :die, Sides = 10, Colour = blue, Sideup =  }
{ Type = :die, Sides = 7, Colour = red, Sideup =  }
{ Type = :die, Sides = 7, Colour = yellow, Sideup =  }"
expected = "Player's bag contains the following: \n#{bag_description}"
actual = "Player's bag contains the following: #{player1.print_bag}"
print_test(2, "Fill player's bag with assorted Dice", "to test the creation of Die objects using RandomizerFactory, and to test storing Randomizers in a player's bag", expected, actual)

# test #3: load cup weth red dice
player1.load({item: :die, colour: :red})
cup_description = "{ Type = :die, Sides = 6, Colour = red, Sideup =  }
{ Type = :die, Sides = 7, Colour = red, Sideup =  }
{ Type = :die, Sides = 7, Colour = red, Sideup =  }"
expected = "Player's cup contains the following: \n#{cup_description}"
actual = "Player's cup contains the following: #{player1.print_cup}"
print_test(3, "Load player's cup with red Dice", "to test the selection of specific Die objects from the Bag and to test loading into the player's cup", expected, actual)

# test #4: throw the cup onto the table and calculate the tally
player1.throw()
throw_tally = player1.tally({item: :die, colour: :red})
expected = "Player's throw tallies 3 red Die objects"
actual = "Player's throw tallies #{throw_tally[0]} red Die objects"
print_test(4, "Throw player's cup onto table and tally score", "to test the throwing of a player's cup and the tallying of the last throw", expected, actual)

# test #5: tally the sum from that throw
throw_sum = player1.sum({item: :die, colour: :red})
expected = "Player's throw sums up to #{throw_sum[0]}"
actual = "Player's throw sums up to #{throw_sum[0]}"
print_test(5, "Sum the player's Dice throw", "to test the calculating the sum of the last Dice throw", expected, actual)

# test #6: test post conditions
expected = "Player's Cup is empty:"
actual = "Player's Cup is empty:#{player1.print_cup}"
print_test(6, "Test post conditions for Use Case 1", "to test the state of the Cup after throwing", expected, actual)

puts "\n\n-------------------------------------------------------"
puts "USE CASE #2 :: player wants to throw a cup of coins"
puts "-------------------------------------------------------\n"

# test #7: create coins using factory & add them to player's bag
player2 = Player.new("Joe")
coin1 = factory.create_coin(0.10)
coin2 = factory.create_coin(0.25)
coin3 = factory.create_coin(0.25)
coin4 = factory.create_coin(0.25)
coin5 = factory.create_coin(0.25)
coin6 = factory.create_coin(0.05)
player2.store(coin1)
player2.store(coin2)
player2.store(coin3)
player2.store(coin4)
player2.store(coin5)
player2.store(coin6)
bag_description = "{ Type = :coin, Sides = 2, Denomination = 0.1, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.05, Sideup =  }"
expected = "Player's bag contains the following: \n#{bag_description}"
actual = "Player's bag contains the following: #{player2.print_bag}"
print_test(7, "Fill player's bag with assorted Coins", "to test the creation of Coin objects using RandomizerFactory", expected, actual)

# test #8: load cup with all quarters
player2.load({item: :coin, denomination: 0.25})
cup_description = "{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 0.25, Sideup =  }"
expected = "Player's cup contains the following: \n#{cup_description}"
actual = "Player's cup contains the following: #{player2.print_cup}"
print_test(8, "Load player's cup with quarters", "to test the selection of specific Coin objects from the player's Bag", expected, actual)
player2.throw()

# test #9: tally the sum from that throw
throw_sum = player2.sum({item: :coin, denomination: 0.25})
expected = "Player's throw sums up to #{throw_sum[0]}"
actual = "Player's throw sums up to #{throw_sum[0]}"
print_test(9, "Sum the player's Coin throw", "to test the calculating the sum of the last throw of coins", expected, actual)

puts "\n\n-------------------------------------------------------"
puts "USE CASE #3 :: player wants to throw a cup of coins AND dice"
puts "-------------------------------------------------------\n"

# test #8: load cup with Die AND Coin objects
player3 = Player.new("Charlie")
die1 = factory.create_die(11, :black)
die2 = factory.create_die(20, :white)
coin1 = factory.create_coin(1)
coin2 = factory.create_coin(2)
player3.store(die1)
player3.store(die2)
player3.store(coin1)
player3.store(coin2)
player3.load({item: :coin})
player3.load({item: :die})
cup_description = "{ Type = :coin, Sides = 2, Denomination = 1, Sideup =  }
{ Type = :coin, Sides = 2, Denomination = 2, Sideup =  }
{ Type = :die, Sides = 11, Colour = black, Sideup =  }
{ Type = :die, Sides = 20, Colour = white, Sideup =  }"
expected = "Player's cup contains the following: \n#{cup_description}"
actual = "Player's cup contains the following: #{player3.print_cup}"
print_test(10, "Load player's cup with all Coin AND Die objects", "to test the selection of both Coin and Die objects from the player's Bag", expected, actual)

# test #11: throw a cup of Dice and Coin objects
p3_throw = player3.throw()
throw_sum_0 = player3.sum({item: :die})
throw_sum_1 = player3.sum({item: :coin})
expected = "Player's throws sum up to [#{throw_sum_0[0]}, #{throw_sum_1[0]}]"
actual = "Player's throws sum up to [#{throw_sum_0[0]}, #{throw_sum_1[0]}]"
print_test(11, "Sum the player's Dice AND Coin throw", "to test the calculating the sum of a throw of Dice AND Coin objects", expected, actual)


puts "\n\n-------------------------------------------------------"
puts "USE CASE #4 :: player wants to report on their score"
puts "-------------------------------------------------------\n"
# test #12: generate report
expected = "Player's report gives: #{throw_sum_1}"
actual = "Player's report gives: #{player3.report}"
print_test(12, "Report the player's score so far", "to test the player's report functionality", expected, actual)


puts "\n\n-------------------------------------------------------"
puts "USE CASE #5 :: player wants to clear their throws to start a new game"
puts "-------------------------------------------------------\n"
# test #13: player clears their throws 
player3.clear
expected = "Player's table is empty: []"
actual = "Player's table is empty: #{player3.print_table}"
print_test(13, "Clear the player's throws list", "to clear the player's throws so they can start a fresh game", expected, actual)

puts "\n\n-------------------------------------------------------"
puts "USE CASE #6 :: library user wants to robustly test library"
puts "-------------------------------------------------------\n"

# test #14: flip a Coin 
coin1 = factory.create_coin(0.5)
coin1.flip
pre_sideup = coin1.sideup
coin1.flip
post_sideup = coin1.sideup
expected = "Coin successfully flipped: #{pre_sideup} to #{post_sideup}"
actual = "Coin successfully flipped: #{pre_sideup} to #{post_sideup}"
print_test(14, "Manually flip a Coin object", "to ensure Coin class can be used independently to flip a coin", expected, actual)

# test #15: get Coin denomination
expected = "Coin denomination: 0.5"
actual = "Coin denomination: #{coin1.denomination}"
print_test(15, "Manually get a Coin's denomination", "to ensure Coin class can be used independently to access the denomination getter", expected, actual)

# test #16: roll a Die
die1 = factory.create_die(25, :black)
die1.roll
pre_sideup = die1.sideup
die1.roll
die1.roll
post_sideup = die1.sideup
expected = "Die successfully rolled: #{pre_sideup} to #{post_sideup}"
actual = "Die successfully rolled: #{pre_sideup} to #{post_sideup}"
print_test(16, "Manually roll a Die object", "to ensure Die class can be used independently to roll a Die", expected, actual)

# test #17: Die getters
expected = "Die colour = black, sides = 25"
actual = "Die colour = #{die1.colour}, sides = #{die1.sides}"
print_test(17, "Manually get a Die's colour & number of sides", "to ensure Coin class can be used independently to access the denomination getter", expected, actual)

# test #18: randomize_count()
expected = "Randomization count for Coin = 2, Die = 3"
actual = "Randomization count for Coin = #{coin1.randomize_count}, Die = #{die1.randomize_count}"
print_test(18, "Manually get a Randomizer's randomize_count", "to ensure Coin and Die class can be used independently to see how many times they have been flipped/rolled", expected, actual)

# test #19: return_items() from the throw
throw_return = p3_throw.return_items
desc = ""
throw_return.items.each do |item|
    desc += item.to_string
end
expected = "Contents of the throw: #{desc}"
actual = "Contents of the throw: #{desc}"
print_test(19, "Call return_items() on a Throw object", "to ensure you can return a copy of the items inside a Throw", expected, actual)
