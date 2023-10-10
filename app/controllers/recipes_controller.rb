class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes_data = Recipe.all
    @user_owner = current_user.id
  end

  def public_recipes
    @public_recipes_data = Recipe.public_recipes
  end

  def show
    @recipe_data = Recipe.find(params[:id])
  end

  def shopping_list
    @user = current_user
    @recipes = @user.recipes || []
    # sumar los items de foods iguales y eso da cantidad
    # restar esa cantidad a la cantidad de esa food que tengo en la lista de foods del usuario
    # Mostrar la cantidad en la tabla
    # Multiplicar esa cantidad por el precio
    # Mostrar el precio
    @user.foods_all_recipes
    @stock_user = {}
    @user.foods_all_recipes.each do |food|
      if @stock_user.key?(food.name)
        @stock_user[food.name] += food.quantity.to_i
      else
        @stock_user[food.name] = food.quantity.to_i
      end
    end
    @foods_needed = {}
    @user.recipes.each do |recipe|
      recipe.foods.each do |food|
        recipe_food = RecipeFood.find_by(recipe_id: recipe.id, food_id: food.id)
        next if recipe_food.quantity.blank?

        if @foods_needed.key?(food.name)
          @foods_needed[food.name] += recipe_food.quantity.to_i
        else
          @foods_needed[food.name] = recipe_food.quantity.to_i
        end
      end
    end
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
