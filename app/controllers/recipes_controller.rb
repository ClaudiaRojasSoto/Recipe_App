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

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  def shopping_list
    @user = current_user
    @recipes = @user.recipes || []
    @stock_user = calculate_user_stock
    @foods_needed = calculate_foods_needed
    @foods_to_buy = calculate_foods_to_buy(@foods_needed, @stock_user)
    @total_price = calculate_total_price
  end

  private

  def calculate_user_stock
    stock = {}
    @user.foods.each do |food|
      if stock.key?(food.name)
        stock[food.name] += food.quantity.to_i
      else
        stock[food.name] = food.quantity.to_i
      end
    end
    stock
  end

  def calculate_foods_needed
    foods_needed = {}
    @user.recipes.each do |recipe|
      recipe.foods.each do |food|
        recipe_food = RecipeFood.find_by(recipe_id: recipe.id, food_id: food.id)
        next if recipe_food.quantity.blank?

        if foods_needed.key?(food.name)
          foods_needed[food.name] += recipe_food.quantity.to_i
        else
          foods_needed[food.name] = recipe_food.quantity.to_i
        end
      end
    end
    foods_needed
  end

  def calculate_foods_to_buy(foods_needed, stock_user)
    foods_to_buy = {}
    foods_needed.each do |k, v|
      quantity_missing = [0, v - (stock_user[k] || 0)].max
      foods_to_buy[k] = quantity_missing if quantity_missing.positive?
    end
    foods_to_buy
  end

  def calculate_total_price
    total_price = 0
    @foods_needed.each do |k, v|
      price = Food.obtener_precio(k)
      quantity_missing = [0, v - (@stock_user[k] || 0)].max
      total_price += quantity_missing * price
    end
    total_price
  end
end
