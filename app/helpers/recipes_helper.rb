module RecipesHelper
  def size_by_food(recipe)
    recipe.foods.count
  end

  def total_foods_by_recipe(user)
    return 0 if user.nil?

    food_names = []

    user.foods_all_recipes.each do |food|
      food_names << food.name
    end

    food_names.uniq.size
  end

  def obtener_precio(food_name)
    puts "Obteniendo precio para: #{food_name}"
    food = Food.find_by(name: food_name)
    price = food ? food.price : 0
    puts "Precio obtenido: #{price}"
    price
  end
end
