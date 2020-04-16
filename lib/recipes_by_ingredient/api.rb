class Api 

    #Creates meal objects and ingredient object from the Api and relates them to each other. 
    def self.get_meals(ingredient)
        
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url)) 
        meals = JSON.parse(response)["meals"] 
        
        if meals

            new_ingredient = Ingredient.new(ingredient) 
            meals.each do |meal|
                new_meal = Meal.new(name: meal["strMeal"], meal_id: meal["idMeal"], ingredient: ingredient)
                new_ingredient.meals << new_meal
            end

        end 

     
        meals
    end 


    #adds addtional details to a chosen meal object
    def self.get_meal_details(meal)
        
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal.meal_id}"
        response = Net::HTTP.get(URI(url)) 

        meal_details = JSON.parse(response)["meals"][0]

        meal_details.keys.each do |key|
           

            valid = (meal_details[key] != "" && meal_details[key] != " " && meal_details[key] != nil)
            
            meal.ingredients << meal_details[key] if (key.include?("Ingredient")) && valid

            meal.measures << meal_details[key] if (key.include?("Measure")) && valid

            meal.category = meal_details[key] if (key.include?("Category")) && valid

            meal.area = meal_details[key] if (key.include?("Area")) && valid
            
            meal.instructions = meal_details[key].gsub(/\r\n/, " ") if (key.include?("Instructions")) && valid

            meal.picture = meal_details[key] if (key.include?("MealThumb")) && valid

            meal.video = meal_details[key] if (key.include?("Youtube")) && valid

        end  

    end 

end 