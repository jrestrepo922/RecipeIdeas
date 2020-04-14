class Cli 

    def run
        puts " "
        puts "Welcome to the RecepiesByIngredient App!"


        puts " "
        puts "Please provide and ingredient so we can provide you a list of tasty recipies"
        puts " "
        @ingredient = gets.strip.downcase 

        #this class method along with Meal class will make a bunch of ojects
        Api.get_meals(@ingredient)

        #what do we want to do with this objecst? 
        #we want to provide a list will do that in a method 
        self.display_meals(Meal.all)

        #now that we have the list we want to tell user there options
        puts " "
        puts "Pick a number to see the recipe, type 'ingredient' and provide ingredient to see a new list of plates"
        puts " "
        puts "type 'list' to see the list again and type 'exit' to exit"

        #need to take in the new input from the choices provided 

        

    end 

    def display_meals(meals)
        meals.each_with_index { |meal, index|
            puts "#{index + 1}.  #{meal.name}"
        }

    end 
end 