class Cli 

    def run
        puts " "
        puts "Welcome to the RecipesByIngredient App!"

        self.prompt_ingredient

        self.prompt 

        #need to take in the new input from the choices provided 
        input = gets.strip.downcase
        
        ## options base on the input taken. Remember to use validation 
            #if a number is typed

        while input != 'exit'

            if input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).meals.length
                # I can see that the meal objects provided by Ingredient.find_by_ingredient(@ingredient).meals have meal_id
                # this meal_id needs to get pass to the api
                meal = Ingredient.find_by_ingredient(@ingredient).meals[input.to_i - 1]

                # needs to check if that recepy was already created. We do not want to create something that is already created.
                Api.get_meal_details(meal) if !meal.instructions 


                self.provide_meal_recipe(meal) 

            elsif input == "list"  

                self.display_meals(Ingredient.find_by_ingredient(@ingredient).meals)

            elsif  input == "ingredient"  

                prompt_ingredient
            else   
                puts " "
                puts " Please try again and choose one of the options given."
                puts " "
            end 
            prompt
            input = gets.strip.downcase
        end 
        puts " "
        puts "Farewell you aspiring cook!!"
        puts " "
    end 

    def display_meals(meals)
        meals.each_with_index { |meal, index|
            puts "#{index + 1}.  #{meal.name}"
        }

    end 

  
    def provide_meal_recipe(meal)
    
        puts " "
        puts "-----------#{meal.name}-----------"
        puts " "
        puts "Picture Link: #{meal.picture}"
        puts " "
        puts "Catergory: #{meal.category}"
        puts " "
        puts "Ingredients and their quantities"
        meal.ingredients.each_with_index do |ingredient, index|
            puts "#{ingredient} - #{meal.measures[index]}"
        end 
        puts " "
        puts "Instructions: #{meal.instructions}"
        puts " " 
        puts "Video: #{meal.video}" if meal.video
        puts " " if meal.video
    end 

    def prompt
          #now that we have the list we want to tell user there options
          puts " "
          puts "Pick a number to see the recipe, type 'ingredient' and provide ingredient to see a new list of plates,"
          puts "type 'list' to see the list again and type 'exit' to exit."  
    end 

    def prompt_ingredient
        puts " "
        puts "Please provide an ingredient so we can provide you a list of tasty recipies"
        puts " "
        @ingredient = gets.strip.downcase.gsub(" ","_")

        #this class method along with Meal class will make a bunch of ojects
        Api.get_meals(@ingredient)
        puts " "
        #what do we want to do with this objecst? 
        #we want to provide a list will do that in a method 
        #self.display_meals(Meal.all) this is incorrect becasue it will pass all the Meal objects in the array without filtering by the current ingredient
            #we can solve this issue by using Ingredient.find_by_ingredient
            #this returns  an ingredient object with many meal objects tide to that specific string ingredient provided 
        if Ingredient.find_by_ingredient(@ingredient)
            self.display_meals(Ingredient.find_by_ingredient(@ingredient).meals)
        else
            puts " "
            puts "The ingredient you provided was not valid."
            puts " "
            puts "Some popular ingredients you can try are: chicken, salmon, beef, pork and avocado."


            prompt_ingredient
        end 
    end 

    def 2puts 

end 