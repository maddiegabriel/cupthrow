class Randomizer

	# abstract def item_type end
	# abstract def descriptor end

	def reset
		@result = nil
		@calls = 0
	end

	def randomize
		@result = rand()
		@calls += 1
	end

	def result
		@result
	end

	def descriptor
		# implemented by subclass
	end

	def initialize(arg1=nil, arg2=nil)
		reset
	end
end	

#################################

class Coin < Randomizer

	def item
		:coin
	end

	def denomination			# returns the denomination of the coin (does not set it)
		@denomination
	end

	def descriptor
		denomination
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		@result = [:H, :T].sample
		#  @result = [:H, :T].rand(0..1)
		@calls += 1
	end

	def flip
		randomize
	end

	def sideup				# returns :H or :T (the result of the last flip) or nil (if no flips yet done) 
		@result
	end 

	def up
		(@result == :H) ? 1 : 0
	end

	def initialize(denom = 1, arg2 = nil)
		raise ArgumentError, "supplied denomination #{denom} is not one of { 0.1, 0.25, 0.5, 1, 2 }" \
		  unless valid_denomination(denom)
		@denomination = denom
		reset
	end

	private

	def valid_denomination(denom)
		case denom
		when 1, 2, 0.5, 0.25, 0.1
			true
		else
			false
		end
	end
end

#################################

class Die < Randomizer
	def item
		:die
	end

	def colour 		# returns the colour of the die (does not set it)
		@colour
	end

	def descriptor
		colour
	end

	def sides			# returns the number of sides ( does not set it)
		@sides
	end

	def randomize				# flips the coin and returns the number of flips performed (not the result)
		@result = rand 1..self.sides
		@calls += 1
	end

	def roll()			# randomizes and returns 
		self.randomize
	end

	def sideup()
		@result
	end 

	def up
		@result
	end

	def initialize(side_count = 6, colour = :white)
		raise ArgumentError, "supplied side count #{side_count} is not an integer greater than 1" \
		  unless valid_sides(side_count)
		@sides = side_count

		raise ArgumentError, "supplied colour #{colour} is not one of { :white, :red, :green, :blue, :yellow, :black }" \
		  unless valid_colour(colour)
		@colour = colour

		reset
	end

	private

	def valid_sides(sides)
		sides.is_a? Integer and sides > 1
	end

	def valid_colour(colour)
		case colour
		when :white, :red, :green, :blue, :yellow, :black
			true
		else
			false
		end
	end
end


###############################

class RandomizerFactory
	def createDie(sides, colour)
		Die.new(sides, colour)
	end

	def createCoin(denomination)
		Coin.new(denomination)
	end
end

