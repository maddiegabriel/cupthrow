class Throw
	def return()				
		# returns the items in the Throw as a Clutch
		clutch = @original_clutch
		@original_clutch = nil
		clutch
	end

	def tally(description)		
		# counts the items in the Throw that match the description
		# and returns the value
		total = 0

		@items.each do |item|
			# selects items from Bag based on the description
			total += 1 if description.all_match(item)
		end

		@result_value = total
	end

	def sum(description)		
		# totals the value of the randomizer items in the Throw that match the description, 
		# where the value equals the number that is “up” (for coins, :H = 1 and :T = 0),
		# and returns the value
		total = 0

		@items.each do |item|
			# selects items from Bag based on the description
			total += item.up if description.all_match(item)
		end

		@result_value = total
	end

	def report()				
		# returns the value from the last tally or sum method call
		@result_value
	end
	
	def initialize(clutch)
		@result_value = nil
		@original_clutch = clutch
		# a record is made of the items so tally() and sum() continue to give the same answers  before and after return is called
		@items = deep_copy_items clutch
	end

	#private

	def deep_copy_items(clutch)
		clutch.duplicate.all_items
	end
end