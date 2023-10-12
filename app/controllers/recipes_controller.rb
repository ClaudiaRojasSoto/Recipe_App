class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes_data = Recipe.all
    @user_owner = current_user.id
  end

  def public_recipes
    @public_recipes_data = Recipe.public_recipes.includes(:user, :foods)
  end

  def show
    @recipe_data = Recipe.includes(:recipe_foods).find(params[:id])
    @foods = @recipe_data.recipe_foods
    # includes(:recipe_foods).where(recipe_foods: { recipe_id: @recipe_data.id })
  end

  def new
    @user_owner = current_user
    @recipe = Recipe.new
  end

  def create
    @recipe_data = Recipe.new(recipe_params)
    @recipe_data.user_id = current_user.id

    if @recipe_data.public.nil?
      @recipe_data.public = false
      puts 'entro al if'
    end

    if @recipe_data.save
      flash[:notice] = 'The recipes was created successfully!'
    else
      flash[:alert] = 'The recipes was not created!'
    end
    redirect_to recipes_path
  end

  def edit; end

  def update_public
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: params[:public])
  end

  def destroy
    @recipe_destroy = Recipe.find(params[:id])
    if @recipe_destroy.destroy
      flash[:notice] = 'The recipes was deleted successfully!'
    else
      flash[:alert] = 'The recipes was not deleted!'
    end
    redirect_to recipes_path
  end

  def shopping_list
    @user = current_user
    @recipes = @user.recipes.includes(recipe_foods: :food) || [] # Añadido .includes(recipe_foods: :food)
    @stock_user = calculate_user_stock
    @foods_needed = calculate_foods_needed
    @foods_needed = sort_foods_needed(@foods_needed)
    @foods_to_buy = calculate_foods_to_buy(@foods_needed, @stock_user)
    @total_price = calculate_total_price
  end

  def sort_foods_needed(foods_needed)
    sort = params[:sort]
    case sort
    when 'food_name_asc'
      foods_needed.sort.to_h
    when 'food_name_desc'
      foods_needed.sort.reverse.to_h
    when 'price_asc'
      foods_needed.sort_by { |food_name, _| Food.obtener_precio(food_name) }.to_h
    when 'price_desc'
      foods_needed.sort_by { |food_name, _| Food.obtener_precio(food_name) }.reverse.to_h
    else
      foods_needed
    end
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
    @user.recipes.includes(recipe_foods: :food).each do |recipe|
      recipe.recipe_foods.each do |recipe_food|
        food = recipe_food.food
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

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
