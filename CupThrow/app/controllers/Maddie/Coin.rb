require_relative 'Randomizer'

# Coin class - Inherits from Randomizer class
class Coin < Randomizer

    # Coin constructor - overrides the Randomizer constructor
    def initialize(denomination)
        @denomination = denomination # set denomintaion value of coin (i.e. 0.10 for dime)
        super(:coin, 2) # call Randomizer constructor (coin always has 2 sides)
    end

    # returns the denomination of the coin (does not set it)
    def denomination()
        @denomination
    end

    # flips the coin - randomizes (calls randomize in RC) and returns the "flipped" coin (for method chaining)
    def flip()
        self.randomize
    end

    # returns :H or :T (result of the last flip) or nil (if no flips yet done)
    def sideup()
        self.result
    end

    # returns a string description of this Coin's attributes (useful for testing)
    def to_string()
        up = ""
        if self.sideup
            up = ", \"up\":\"#{self.sideup}\""
        end

        "\n{ \"item\":\":coin\", \"denomination\":#{self.denomination} #{up} }"
    end
 end