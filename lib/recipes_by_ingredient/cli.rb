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
        puts " "
        #what do we want to do with this objecst? 
        #we want to provide a list will do that in a method 
        #self.display_meals(Meal.all) this is incorrect becasue it will pass all the Meal objects in the array without filtering by the current ingredient
            #we can solve this issue by using Ingredient.find_by_ingredient
            #this returns  an ingredient object with many meal objects tide to that specific string ingredient provided 
        self.display_meals(Ingredient.find_by_ingredient(@ingredient).meals)
        #now that we have the list we want to tell user there options
        puts " "
        puts "Pick a number to see the recipe, type 'ingredient' and provide ingredient to see a new list of plates"
        puts " "
        puts "type 'list' to see the list again and type 'exit' to exit"
        puts " "
        #need to take in the new input from the choices provided 

        input = gets.strip.downcase
        
        ## options base on the input taken. Remember to use validation 
            #if a number is typed
        if input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).meals.length
            # I can see that the meal objects provided by Ingredient.find_by_ingredient(@ingredient).meals have meal_id
            # this meal_id needs to get pass to the api
            meal = Ingredient.find_by_ingredient(@ingredient).meals[input.to_i - 1]



            
            Api.get_meal_details(meal)
        #elsif  #if list is typed
            
        #elsif  #if ingredient is typed

        #elsif  #if exit was typed 

        else   #if something else was typed
            puts " "
            puts " Please choose one of the options provided above"
            puts " "
        end 
    end 

    def display_meals(meals)
        meals.each_with_index { |meal, index|
            puts "#{index + 1}.  #{meal.name}"
        }

    end 
end 