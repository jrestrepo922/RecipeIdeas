class Ingredient
    attr_accessor :name, :meals 

    @@all = []

    def initialize(name)
        @name = name 
        @meals = [] #ingredient has many meals 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 

    # this gives the ability to do find an ingredient object and look through is drinks
    # takes in a ingredient string and returns an object with mehtods that can be call on.  
    def self.find_by_ingredient(ingredient)
        @@all.find{ |i| i.name == ingredient} 
    end 
end 