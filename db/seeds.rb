# require 'pry'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Meal.destroy_all
Meal.reset_pk_sequence

RecipeIngredient.destroy_all
RecipeIngredient.reset_pk_sequence

Recipe.destroy_all
Recipe.reset_pk_sequence

Ingredient.destroy_all
Ingredient.reset_pk_sequence


def request_api(url)
    response = Excon.get(
      url,
      headers: {
        'Host' => URI.parse(url).host
      }
    )
    return nil if response.status != 200
    parsed = JSON.parse(response.body)
    new_array = parsed.map { |recipe| recipe }[0] # looks like ["meals", [{recipe 1},{recipe 2}]]  
    new_array[1]
end

def find_recipes(letter)
  request_api(
  "https://www.themealdb.com/api/json/v1/1/search.php?f=#{letter}"
  )
end

# def get_recipe_info(id)
#   request_api(
#       "https://www.themealdb.com/api/json/v1/1/lookup.php?i=#{id}"
#   )
# end

def get_ingredients()
    request_api(
        "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
    )
end

# def get_ingredients_amounts (recipe_hash)
#     ingredients = get_ingredients_for_recipe(recipe_hash)
#     amounts = get_amounts(recipe_hash)
#     Hash[ingredients.zip(amounts)]
# end

# def get_ingredients_for_recipe(recipe_hash)
#     ingredients = []
#     recipe_hash.each do |category, value|
#         if category.include?("strIngredient") && value != nil && value != "" 
#             ingredients << value
#         end 
#     end
#     ingredients
# end

# def get_amounts(recipe_hash)
#     amounts = []
#     recipe_hash.each do |category, value|
#         if category.include?("strMeasure") && value != nil && value != "" 
#             amounts << value
#         end 
#     end
#     amounts
# end

puts "getting ingredients"

food_items = get_ingredients 
food_items.each do |food_item|
    Ingredient.create(name: food_item["strIngredient"].downcase)
end

puts "ingredients done, getting recipes"

def get_ingredients_for_recipe(recipe_hash)
    ingredients = []
    recipe_hash.each do |category, value|
        if category.include?("strIngredient") && value != nil && value != "" 
            ingredients << value
        end 
    end
    ingredients
end

def create_recipe_ingredients(ingredients, recipe)
    ingredients.each do |ingredient|
        food = nil
        ingredient = ingredient.downcase
        if ingredient == "carrot"
            food = Ingredient.find_by(name: "carrots")
        elsif ingredient == "red onion"
            food = Ingredient.find_by(name: "red onions")
        elsif ingredient == "blackberrys"
            food = Ingredient.find_by(name: "blackberries")   
        elsif ingredient.include? "butter"     
            food = Ingredient.find_by(name: "butter")
        elsif ingredient.include? "green chili"     
            food = Ingredient.find_by(name: "green chilli")
        elsif ingredient == "red chili powder"     
            food = Ingredient.find_by(name: "red chilli powder")
        elsif ingredient == "all spice"     
            food = Ingredient.find_by(name: "allspice")    
        elsif ingredient == "spring onion"
            food = Ingredient.find_by(name: "spring onions")
        elsif ingredient == "chicken thigh"
            food = Ingredient.find_by(name: "chicken")
        elsif ingredient == "gruyere cheese"
            food = Ingredient.find_by(name: "cheese")
        elsif ingredient == "tarragon"
            food = Ingredient.find_by(name: "tarragon leaves")
        elsif ingredient == "potato"
            food = Ingredient.find_by(name: "potatoes")
        elsif ingredient == "clove"
            food = Ingredient.find_by(name: "cloves")
        elsif ingredient == "tomato purée"
            food = Ingredient.find_by(name: "tomato puree")
        elsif ingredient == "red chili"     
            food = Ingredient.find_by(name: "red chilli")
        elsif ingredient == "harissa"     
            food = Ingredient.find_by(name: "harissa spice")
        elsif ingredient == "vermicelli"     
            food = Ingredient.find_by(name: "rice vermicelli")
        elsif ingredient == "self raising flour"     
            food = Ingredient.find_by(name: "self-raising flour")
        else
            food = Ingredient.find_by(name: ingredient.downcase)
        end

        if food
            RecipeIngredient.create(recipe_id: recipe.id, ingredient_id: food.id)
        else
            puts "#{ingredient} does not have a corresponding food in the foods table"
            byebug
        end
    end
end

letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
letters.each do |letter| 
    recipes = find_recipes(letter)
    if recipes && recipes.size > 0
        recipes.each do |recipe|
            
            recipe_entry = Recipe.create(name: recipe["strMeal"], 
            instructions: recipe["strInstructions"],
            image: recipe["strMealThumb"],
            typeOfMeal: recipe["strCategory"] )

            #loop through all the ingredients of the recipe
            puts "getting recipe ingredients for #{recipe["strMeal"]}"
            ingredients = get_ingredients_for_recipe(recipe)
            
            #create a RecipeIngredient for each ingredient if it is in the ingredients table
            create_recipe_ingredients(ingredients, recipe_entry)
            # puts "done getting recipe for #{recipe["strMeal"]}"
            
            #create a Meal for each of these ingredients
        end
    end
end


puts "recipes done"

# Recipe.create(name: recipe["strMeal"], 
#             meal: recipe["strCategory"], 
#             cuisine: recipe["strArea"], instructions: recipe["strInstructions"], completed: true,
#             api_id: recipe["idMeal"], image_url: recipe["strMealThumb"] )

puts "getting meals"
5.times do

    recipe_ingredient = RecipeIngredient.all.sample
    recipe = Recipe.find_by(id: recipe_ingredient.recipe_id)
    Meal.create(typeOfMeal: recipe.typeOfMeal, recipe_ingredients_id: recipe_ingredient.id, date: %w(Monday Tuesday Wednesday Thursday Friday).sample)
    byebug

end



