class Api 

    def self.get_meals(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url)) 

        meals = JSON.parse(response)["meals"] # provides and array of meals base on ingredient provided
        

        #now we want to make objects out the arrary fill with hashes
        # will take the name of the meal and the id of the meal to get the details
        new_ingredient = Ingredient.new(ingredient) #instance of ingredient is created
        meals.each do |meal|
            new_meal = Meal.new(name: meal["strMeal"], meal_id: meal["idMeal"], ingredient: ingredient)
            new_ingredient.meals << new_meal
        end 
    end 


    def self.get_meal_details(meal)
        url = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{meal.meal_id}"
        response = Net::HTTP.get(URI(url)) 

        meal_details = JSON.parse(response)["meals"] 
        binding.pry 
    end 
end 