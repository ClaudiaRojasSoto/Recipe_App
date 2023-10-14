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

  def total_foods_to_buy(foods_to_buy)
    return 0 if foods_to_buy.nil?

    foods_to_buy.size
  end
end
