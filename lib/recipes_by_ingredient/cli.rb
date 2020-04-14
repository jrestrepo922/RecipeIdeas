class Cli 

    def run
        puts " "
        puts "Welcome to the RecepiesByIngredient App!"

        puts " "
        puts "Please provide and ingredient so we can provide you a list of tasty recipies"
        @ingredient = gets.strip.downcase 

        Api.get_meals(@ingredient)

    end 
end 