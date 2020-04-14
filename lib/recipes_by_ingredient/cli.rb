class Cli 

    def run
        puts " "
        puts "Welcome to the RecepiesByIngredient App!"

        puts " "
        puts "Please provide and ingredient so we can provide you a list of tasty recipies"
        @ingredient = gets.strip.downcase 
        
    end 
end 