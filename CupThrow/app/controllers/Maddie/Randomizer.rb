# Randomizer class - Parent class of Die/Coin
class Randomizer

    # getter for the object type (useful for testing outside of irb)
    attr_reader :type

    # Randomizer constructor
    def initialize(type, sides)
        @type = type # specify if this is a :coin or :die
        @sides = sides # number of sides (always 2 sides on a coin; X sides on a die). nil if none
        @sideup = nil # if coin, 0 (T) or 1 (H). if die, X (the number facing up, from 1..@sides)
        @rand_count = 0 # initialize to zero, increment each time object is randomized
    end

    # both randomizes and returns the randomizer itself (for method chaining)
    def randomize()
        @rand_count += 1
        if @type == :coin
            # if coin, set @sideup instance var to a random number between 0 - 1
            @sideup = rand(0..1)
        else
            # if die, set @sideup instance var to a random number between 1 - sides
            @sideup = rand(1..@sides)
        end
        self
    end

    # returns the result of the randomization (@sideup), which is nil if never randomized
    def result()
        result = @sideup
        # if coin, return the corresponding :T (0) or :H (1) to represent the "sideup"
        if @type == :coin && @sideup == 0
            result = :T
        elsif @type == :coin && @sideup == 1
            result = :H
        end
        result
    end

    # returns the number of randomizations performed
    def randomize_count()
        @rand_count
    end

    # sets the result to nil and number of randomizations performed to 0
    def reset()
        @rand_count = 0
        @sideup = nil
    end
 end