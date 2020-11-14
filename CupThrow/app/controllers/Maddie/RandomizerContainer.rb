# RandomizerContainer - Parent class of Bag, Clutch, Cup
class RandomizerContainer

    # getter for the items list (useful for testing outside of irb)
    attr_accessor :items

    # RandomizerContainer constructor
    def initialize()
        @items = [] # each RandomizerContainer holds a list of Randomizers (aka Die/Coin objects)
    end

    # stores a given Randomizer in this RandomizerContainer
    def store(r)
        # add the given a Randomizer r to the @items list for this container
        @items.push(r)
    end

    # gets each randomizer in rc & stores it in this RandomizerContainer
    def add(rc)
        # iterate over given rc and store each item in this RandomizerContainer's list
        rc.items.each do |item|
            self.store(item)
        end
        # empty the given RandomizerContainer items list
        rc.items = []
    end

    # removes all members of the container (clears @items)
    def empty()
        @items.clear
    end

    # return a description of all the items in this RandomizerContainer
    def items_to_string()
        desc = "{"
        @items.each_with_index do |item, index|
            desc += "\"#{index}\":#{item.to_string}"
            if (@items.length - 1) != index
                desc += ","
            end
        end
        desc += "}"
        return desc
    end
 end