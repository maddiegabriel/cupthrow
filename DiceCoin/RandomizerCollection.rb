# class RandomizerCollection
# 	def add(rc) 	
# 		# gets each randomizer in rc & stores items in the new collection, emptying rc by the end
# 		if rc.is_a?(Clutch)
# 			self.add_clutch rc
# 		else
# 			self.add_clutch rc.empty
# 		end
# 	end
# end

class RandomizerCollection
	def item_count
		@items.length
	end

	def store(r)			
		raise ArgumentError, "argument #{r} is not  a randomizer" unless r.is_a? Randomizer
		@items << r
		self
	end

	def add(rc) 	
		# gets each randomizer in rc & stores items in the new collection, emptying rc by the end
		add_clutch rc.empty_to_clutch
		self
	end

	def add_clutch(items)
		while (item = items.next) != nil
			store(item) 
		end
		self
	end

	# def add(objects*)				
	# 	# a series of coins or dice, separated by commas
	# end

	def empty_to_clutch
		# returns a Clutch of all items in the collection and resets the collection (sets it to empty)
		clutch = Clutch.new
		@items.each { |item| clutch.store(item) }
		reinitialize
		clutch
	end

	def empty
		empty_to_clutch
	end

	def reset
		@items.each { |item| item.reset }
		self
	end

	def dup_items							
		# change items for clones; the item content is the same but now resides elsewhere in memory 
		# the originals items are discarded from this object, but if they reside elsewhere
		# in another container/object, they are left alone and untouched
		@items = @items.map { |it| it.dup }
		self
	end

	def duplicate 				# a deep copy
		sd = self.dup
		sd.dup_items
	end

	def initialize(it = [])
		@items = it
	end

	private

	def reinitialize
		@items = []
	end
end


#######################

class Hash
	def all_match(item)
		matches = true
		self.each do |key, value|
			matches &= (item.send(key) == value) 
		end
		matches
	end
end

#################################################

class Bag < RandomizerCollection

	def store(r)			
		# when store() invoked, Bag makes sure that randomizer r is reset
		r.reset
		super
	end

	def add(rc) 	
		# when store() invoked, Bag makes sure that all randomizers added are reset
		rc.reset
		super
	end

	def select(description, amt=:all)  	
		#initialize return object
		clutch = Clutch.new

		# initialize local variables
		amt = item_count if (amt == :all) 
		indices_to_delete = []
		
		@items.each.with_index do |item, i|
			# selects items from Bag based on the description
			if description.all_match item
				indices_to_delete << i 
				clutch.store item
			end

			# up to the number entered into amount
			if indices_to_delete.length >= amt
				break
			end
		end

		# remove selected items from the bag
		remove_at indices_to_delete

		#  return the Clutch object that is holding the selected items
		clutch

	end

	private

	def remove_at(indices)
		indices.reverse.each do |del|			# reverses to delete from back to front, ow unstable
			@items.delete_at del 				# delete.at is an array method
		end
	end

end

#################################################

class Clutch < RandomizerCollection
	def next 					
		# removes and returns the last objected added 
		# if no objects stored, return nil
		@items.pop
	end

	def empty				
		# removes all members of the collection (spilling them on the ground) and returns nil
		@items = []
		nil
	end

	def empty_to_clutch				
		# removes all members of the collection and returns a new clutch with the original values in it
		new_clutch = self.dup
		empty
		new_clutch
	end

	def all_items
		@items
	end

end

#################################################

class Cup < RandomizerCollection
	def throw				
		# each item in the cup is rolled or flipped,
		@items.each do |item|
			item.randomize
		end

		# all items are removed and stored in a Throw object, and returned
		Throw.new(self.empty)
	end

	def load(clutch)				# enters each randomizer from a clutch (synonym of add())
		add clutch
	end

end
