require_relative 'RandomizerContainer'
require_relative 'Clutch'

# Bag class inherits from RandomizerContainer class
class Bag < RandomizerContainer

    # Bag constructor simply calls RandomizerContainer constructor
    def initialize()
        super
    end

    # Overrides the store() method in RandomizerContainer
    def store(r)
        # when store() is invoked, Bag makes sure that all randomizers to be stored are reset
        r.reset
        super(r)
    end

    # Overrides the add() method in RandomizerContainer
    def add(rc)
        # iterate over given rc and store each item in this Bag's list
        rc.items.each do |item|
            # use the Bag's store method to ensure items are reset
            self.store(item)
        end
        # empty the given rc using its own empty method
        rc.items = []
    end

    # returns a Clutch filled with items selected from Bag based on the given description/amount
    # if you want all items, pass in amt = :all instead of a number
    def select(description, amt)
        hand = Clutch.new() # this new Clutch will store the selection

        # iterate over @items in Bag. if item matches the description, add to clutch
        items.each do |item|
            # stop if items added to hand reaches the max amount 
            break if hand.items.length == amt

            next if description[:item] != nil && description[:item] != item.type
            next if description[:sides] != nil && description[:sides] != item.sides
            next if description[:colour] != nil && description[:colour] != item.colour
            next if description[:denomination] != nil && description[:denomination] != item.denomination

            hand.store(item)
        end

        # remove all the items we took out the bag from the Bag's @items list
        self.items = self.items - hand.items
        hand
    end

    # returns a Clutch of all items from the Bag
    def empty()
        hand = Clutch.new()
        # add all the items in the Bag to the new Clutch. also empties the bag
        hand.add(bag)
        hand
    end
 end