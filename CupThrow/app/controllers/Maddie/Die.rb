require_relative 'Randomizer'

# Die class - Inherits from Randomizer class
class Die < Randomizer

    # Die constructor - overrides the Randomizer constructor
    def initialize(sides, colour)
        @colour = colour # set the colour of this die
        super(:die, sides) # call Randomizer constructor
    end

    # returns the colour attribute of the die (does not set it)
    def colour()
        @colour
    end

    # returns the number of sides attribute for this die (does not set it)
    def sides()
        @sides
    end

    # rolls the die - randomizes (calls randomize in RC) and returns the “rolled” die (for method chaining)
    def roll()
        self.randomize
    end

    # returns 1..@sides or nil by calling result() in RC to get @sideup variable
    def sideup()
        self.result
    end

    # returns a string description of this Die's attributes (useful for testing)
    def to_string()
        up = ""
        if self.sideup
            up = ", \"up\":#{self.sideup}"
        end
        "\n{ \"item\":\":die\", \"sides\":#{self.sides}, \"colour\":\"#{self.colour}\" #{up} }"
    end
 end