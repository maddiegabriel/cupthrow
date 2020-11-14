require_relative 'RandomizerContainer'

# Clutch class inherits from RandomizerContainer class
class Clutch < RandomizerContainer
    
    # Clutch constructor simply calls RandomizerContainer constructor
    def initialize()
        super
    end
    
    # removes and returns the last object added to the clutch. if no objects stored, returns nil
    def next()
        # pop the last item of @items and return it
        self.items.pop
    end

    # returns nil (items are “spilled on the ground”)
    # i.e. the pointers to the contained objects are lost (and the objects will be garbage collected by the system)
    def empty()
        super # call empty in RC to clear the list
        return nil
    end
 end