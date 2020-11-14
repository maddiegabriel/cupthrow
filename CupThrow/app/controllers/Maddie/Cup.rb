require_relative 'RandomizerContainer'
require_relative 'Throw'
require_relative 'Clutch'

class Cup < RandomizerContainer 

    def initialize()
        super
    end

    # each item in the cup is rolled or flipped,
    # all items are removed and stored in a Throw object,
    # the newly created Throw object is returned
    def throw()
        # iterate through @items list for this cup, randomize each one and add it to hand
        self.items.each do |item|
            item.randomize
        end

        # create new throw with randomized items in the new clutch
        table = Throw.new(self.items)
        # empty the cup
        self.items = []
        table
    end

    # enters each randomizer from a clutch (synonym of add())
    def load(c)
        # call cup.add(clutch) to add all items from clutch into the cup
        self.add(c)
        c.empty
    end

    # returns a Clutch object to be returned to the bag, leaves the cup empty
    def empty()
        # create new clutch, add everything from cup to clutch
        hand = Clutch.new()
        hand.add(self)
        super # call empty on cup
        hand # return clutch
    end
 end