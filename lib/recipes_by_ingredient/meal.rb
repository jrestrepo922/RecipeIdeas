class Meal 
    
    attr_accessor :name, :meal_id, :ingredient, :category, :area, :instructions, :picture, :video, :ingredients, :measures


    @@all = []

    def initialize(name: , meal_id: , ingredient:) 
        @name = name                 # Passed from the Api
        @meal_id = meal_id           # Passed from the Api
        @ingredient = ingredient     # Passed from the @ingredients 
        @ingredients = [] 
        @measures = [] 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 


end 