require_relative 'Bag'
require_relative 'Cup'
require_relative 'Clutch'

class GamePlayer 
    attr_accessor :table_throws
    
    def initialize(name)   
        @name = name
        @bag = Bag.new()
        @cup = Cup.new()
        @hand = Clutch.new()
        @table_throws = [] # holds list of all Throws that have been on table
        @last_tally_sum = [] # holds list of result of last throw to tally or sum
    end

    # returns the name of the player (does not set it)
    def name()
        @name
    end

    # stores the item (Randomizer) in the player’s bag
    def store(item)
        @bag.store(item) # where item is the Die/Coin created by the factory
    end

    # gets each item in rc (RandomizerContainer) and stores it in the player’s bag
    def add(rc)
        @bag.add(rc) # where rc is a clutch or cup or whatever
    end

    # loads items from the player’s bag to the player’s cup based on the description
    def load(description)
        @cup.load(@bag.select(description, :all))
    end

    # throws the (previously loaded) cup, both returns the throw and stores it internally
    # replaces the items in the cup to the bag
    def throw()
        # add new Throw from throwing the cup to @table_throws
        table = @cup.throw
        @table_throws.push(table)
        table
    end

    # clears all stored throws
    def clear()
       @table_throws.clear
    end

    # calls tally(description) on each stored throw and returns the combined values as an array
    def tally(description)
        # iterate @table_throws and call .tally() on each one
        # add result of each call to @last_tally_sum and return
        @last_tally_sum = []
        @table_throws.each do |throw|
            @last_tally_sum.push(throw.tally(description))
        end
        @last_tally_sum
    end

    # calls sum(description) on each stored throw and returns the combined values as an array
    def sum(description)
        # iterate @table_throws and call .sum() on each one
        # add result of each call to @last_tally_sum and return
        @last_tally_sum = []
        @table_throws.each do |throw|
            @last_tally_sum.push(throw.sum(description))
        end
        @last_tally_sum
    end

    # returns the values as an array from the last tally or sum method call
    def report()
        @last_tally_sum
    end

    # just print all the items in the bag
    def print_bag()
        @bag.items_to_string
    end

    # just print all the items in the cup
    def print_cup()
        @cup.items_to_string
    end

    # just print all the items in the bag
    def print_table()
        desc = []
        @table_throws.each do |thisthrow|
            thisthrow.items.each do |item|
                desc.push(item.to_string)
            end
        end
        desc
    end
 end