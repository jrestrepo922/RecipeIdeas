class Ingredient

    attr_accessor :name, :meals 

    @@all = []

    def initialize(name)

        @name = name 
        @meals = [] 
        @@all << self 

    end 

    def self.all 

        @@all 

    end 

  
    def self.find_by_ingredient(ingredient)

        @@all.find{ |i| i.name == ingredient} 

    end 
end 