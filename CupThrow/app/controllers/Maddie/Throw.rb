require_relative 'Clutch'

# Stores all items from cup when cup.throw() is called (throw = table)
class Throw 

    attr_accessor :items

    def initialize(items)
        @items = items # set clutch array to this
        @last_tally_sum = 0
    end

    # returns the items in the Throw as a Clutch
    # a record is made of the items so tally() and sum() continue to give the same answers to the same input description before and after return is called
    def return_items()
        # create a new clutch
        items_record = @items
        hand = Clutch.new()
        # add all items from throw (@items) to the new clutch.store()
        hand.add(self)
        @items = items_record
        # return the new clutch 
        hand
    end

    # counts the items in the Throw that match the description and returns the value
    def tally(description)
        matches = 0
        # iterate @items_on_table. how many items in that list match the given description?
        @items.each do |item|
            next if description[:item] != nil && description[:item] != item.type
            next if description[:sides] != nil && description[:sides] != item.sides
            next if description[:colour] != nil && description[:colour] != item.colour
            next if description[:up] != nil && description[:up] != item.sideup
            next if description[:denomination] != nil && description[:denomination] != item.denomination
            matches += 1
        end
        # update @last_tally_sum, and return that number
        @last_tally_sum = matches
        @last_tally_sum
    end

    # totals the value of the randomizer items in the Throw that match the description,
    # where the value equals the number that is “up” (for coins, :H = 1 and :T = 0),
    # and returns the value
    def sum(description)
        sum = 0
        # iterate @items_on_table. for each item in that list that matches the given description, sum += @sideup value
        items.each do |item|
            next if description[:item] != nil && description[:item] != item.type
            next if description[:sides] != nil && description[:sides] != item.sides
            next if description[:colour] != nil && description[:colour] != item.colour
            next if description[:up] != nil && description[:up] != item.sideup
            next if description[:denomination] != nil && description[:denomination] != item.denomination

            if item.type == :die
                sum += item.sideup
            elsif item.sideup == :H
                sum += 1
            end
        end
        # update @last_tally_sum, return that number
        @last_tally_sum = sum
        @last_tally_sum
    end

    # returns the value from the last tally or sum method call
    def report()
        @last_tally_sum
    end

    def empty()
        self.return_items
    end

    # return a description of all the items in this throw
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