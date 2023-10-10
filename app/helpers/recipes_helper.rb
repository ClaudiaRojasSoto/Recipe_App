module RecipesHelper
  def size_by_food(recipe)
    recipe.foods.count
  end
end
