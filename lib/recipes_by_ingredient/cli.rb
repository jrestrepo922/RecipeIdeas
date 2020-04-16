class Cli 

    # Run instance method handles all the ouput and input for the user. 
    def run

        puts " "
        puts "Welcome to RecipesByIngredient App!"
        puts " "

        # Run the instance method and collect a true or false value. 
        validate_prompt_ingredient = self.prompt_ingredient

        # While validate_prompt_ingredient is false the condition will be true.
        # The loop will run as long as the condition is true, calling out the instance method prompt_ingredient.
        while !validate_prompt_ingredient do 
            validate_prompt_ingredient = self.prompt_ingredient
        end 
        
        puts " "

        # Prints options for the user. 
        self.prompt 

        # Takes an input based on the options provided to user. 
        input = gets.strip.downcase
       
        # Logic for the menu.
        while input != "exit"

            # Inputs must be within the list numbers provided.
            if input.to_i > 0 && input.to_i <= Ingredient.find_by_ingredient(@ingredient).meals.length

                # Looks throught Ingredients.all and compares ingredient instance getter method to the string pass in @ingredient.
                # If is a match returns the matching ingredient object which has many meals (getter method) and a specific element in the array is selected and set equals to meal.
                meal = Ingredient.find_by_ingredient(@ingredient).meals[input.to_i - 1]

                # Checks to see if a recepy was already created. 
                # If is already created skip this line and provide the recipe details.
                # If not create the details and add to the meal object 
                Api.get_meal_details(meal) if !meal.instructions 

                # Print Recipe details 
                self.provide_meal_recipe(meal) 

            elsif input == "list"  

                # Displays the list of the current ingredient.
                self.display_meals(Ingredient.find_by_ingredient(@ingredient).meals)

            elsif  input == "ingredient"  
                
                self.prompt_ingredient

            else  

                # Takes care of any other inputs provided 
                puts " Please try again and choose one of the options given."
                puts " "

            end 

            # Once it travel trough all the logic the options are provided again and input requested and evaluated by the while loop again.
            # This will be and endless loop unless input is equal to "exit".
            prompt
            input = gets.strip.downcase

        end 

        # If input equal to exit, the loop is exited and a farewell message prints. 
        puts " "
        puts "Farewell you aspiring cook!!"
        puts " "

    end 


    # Displays a list of meal objects created by the provided ingredient.
    def display_meals(meals)

        meals.each_with_index { |meal, index|
            puts "#{index + 1}.  #{meal.name}"
        }

    end 

    
    # Provides  all the details about a specific meal
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
        puts "------------------------------------------------------"

    end 
    

    # Tells the user the options that are avaliable. 
    def prompt
          
          puts " "
          puts "Pick a number to see the recipe, type 'ingredient' and provide ingredient to see a new list of plates,"
          puts "type 'list' to see the list again and type 'exit' to exit."  
          puts " "

    end 



    # Prints a message asking for an ingredient.
    # Takes in the ingredient input and an Ingredient object is made and Many meal objects are made.
    # Prints out a list of the meal objects 
    def prompt_ingredient

        puts "Please provide an ingredient so we can provide you a list of tasty recipies"
        puts " "
        
        @ingredient = gets.strip.downcase.gsub(" ","_")

        # if the @ingredient is an empty string, nil or string with only a space enter loop.
        # keep looping until the @ingredient no longer is an  empty string, nil or string with only a space
        while  (@ingredient == ""  ||  @ingredient == " " || @ingredient == nil) do
        
            puts "Input can not be left blank try again."
            puts " "
            @ingredient = gets.strip.downcase.gsub(" ","_")

        end 

        # Ingredient.find_by_ingredient(@ingredient) takes in a string of ingredient and compares to the instances of Ingredient Class instance getter method name
        # and if there is a match than returns true or false if no match.
        # If True than false becasue of the ! and if false than true. 
        # If condition is true than Api.get_meals(@ingredient) gets executed and object meals are created  and set equals to validate_meals.
        # If condition is false  than validate_message = true
        !Ingredient.find_by_ingredient(@ingredient) ? validate_meals = Api.get_meals(@ingredient) : validate_meals = true

        # If validate_meals is true than the condition is false and the if statement is not enter and the list of meals will display and return true
        # If validate_meals in false than the condition is true and the if statment is enter and an error message will be display to user and will return false
        if !validate_meals 

            puts " "
            puts "The ingredient you provided was not valid."
            puts " "
            puts "Some popular ingredients you can try are: chicken, salmon, beef, pork and avocado."  
            false 

        else 
       
            self.display_meals(Ingredient.find_by_ingredient(@ingredient).meals)

            true 

        end
    end 
end 