class Meal 
    # the rest of the attributes will be insterted by second level deep api 
    attr_accessor :name, :meal_id, :ingredient, :category, :area, :instructions, :picture, :video, :ingredients, :measures


    @@all = []

    def initialize(name: , meal_id: , ingredient:) 
        @name = name  # will be pass from the Api
        @meal_id = meal_id  # will be pass form the Api
        @ingredient = ingredient #will be pass from the input collected from the user 
        @ingredients = [] 
        @measures = [] 
        @@all << self 
    end 

    def self.all 
        @@all 
    end 


end 