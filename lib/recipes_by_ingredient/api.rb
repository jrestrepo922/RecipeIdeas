class Api 

    def self.get_meals(ingredient)
        url = "https://www.themealdb.com/api/json/v1/1/filter.php?i=#{ingredient}"
        response = Net::HTTP.get(URI(url)) 

        meals = JSON.parse(response)["meals"] # provides and array of meals base on ingredient provided
        binding.pry 

        #now we want to make objects out the arrary fill with hashes
        # will take the name of the meal and the id of the meal to get the details

        
    end 
end 