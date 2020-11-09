class Player
	def name
		# returns the name of the player (does not set it)
		@name
	end

	def store(item)
		# stores the item in the player’s bag
		@bag.store item
	end

	def add(container)
		# gets each item in supplied container and stores it in the player’s bag
		@bag.add container.empty_to_clutch
	end
	
	def load(description, amt=:all)
		# loads items from the player’s bag to the player’s cup based on the description
		@cup.load @bag.select(description, amt)
	end

	def throw(the_throw = nil)
		# throws the cup (ignores the throw object possibly handed to it ... was a typo in the assignment)
		the_throw = @cup.throw

		# replaces the items in the cup to the bag,
		@bag.add the_throw.return

		# both returns the throw and stores it internally
		@throws << the_throw
		the_throw
	end

	def clear
		# clears all stored throws
		@throws = []
	end

	def tally(description)		
		# calls tally(description) on each stored throw
		#    and returns the combined values as an array

		@result = @throws.map { |a_throw| a_throw.tally(description) }
	end

	def sum(description)		
		# calls sum(description) on each stored throw
		# and returns the combined values as an array

		@result = @throws.map { |a_throw| a_throw.sum(description) }
	end

	def report				
		# returns the values as an array  
		# from the last tally or sum method call
		@result
	end

	def initialize(the_name)
		raise ArgumentError, "supplied name #{the_name} should be a string, but is a #{the_name.class}" \
		  unless the_name.is_a? String
		@name = the_name
		@bag = Bag.new
		@cup = Cup.new
		@throws = []
		@result = nil
	end
end
