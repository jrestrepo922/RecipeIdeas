class Api 

    def self.get_meals(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url)) 
        meals = JSON.parse(response)["meals"] # provides and array of meals base on ingredient provided
        
        if !meals 
            puts " "
            puts "The ingredient you provided was not valid."
            puts " "
            puts "Some popular ingredients you can try are: chicken, salmon, beef, pork and avocado."
        else 
            new_ingredient = Ingredient.new(ingredient) #instance of ingredient is created
            meals.each do |meal|
                new_meal = Meal.new(name: meal["strMeal"], meal_id: meal["idMeal"], ingredient: ingredient)
                new_ingredient.meals << new_meal
            end
        end 
        #now we want to make objects out the arrary fill with hashes
        # will take the name of the meal and the id of the meal to get the details

     
        meals
    end 


    def self.get_meal_details(meal)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal.meal_id}"
        response = Net::HTTP.get(URI(url)) 

        meal_details = JSON.parse(response)["meals"][0]

        # what do we want to do with the meal details? 
            # We want to add the addional information to the choosen meal. 
            # we can iterate over the keys array 
        meal_details.keys.each do |key|
            # will be shoveling into the meal.ingredients (instance variable that is an empty array)
            # what will be shoveling is the values of the the keys with the name ingredient in them and that are not am empty string

            valid = (meal_details[key] != "" && meal_details[key] != " " && meal_details[key] != nil)
            
            meal.ingredients << meal_details[key] if (key.include?("Ingredient")) && valid

            meal.measures << meal_details[key] if (key.include?("Measure")) && valid

            meal.category = meal_details[key] if (key.include?("Category")) && valid

            meal.area = meal_details[key] if (key.include?("Area")) && valid
            
            meal.instructions = meal_details[key].gsub(/\r\n/, " ") if (key.include?("Instructions")) && valid

            meal.picture = meal_details[key] if (key.include?("MealThumb")) && valid

            meal.video = meal_details[key] if (key.include?("Youtube")) && valid
        end 
    meal    

    end 

end 