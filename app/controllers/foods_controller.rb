class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = if params[:sort] == 'name'
               current_user.foods.where(is_deleted: false).order('LOWER(name)')
             else
               current_user.foods.where(is_deleted: false)
             end
  end

  def new
    @food = Food.new
  end

  def create
    formatted_name = format_food_name(food_params[:name])
    existing_food = current_user.foods.find_by(name: formatted_name)

    if existing_food
      update_existing_food(existing_food)
    else
      create_new_food(formatted_name)
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.update(is_deleted: true)
      flash[:notice] = 'Food was successfully "deleted".'
    else
      flash[:alert] = 'Failed to "delete" food!'
    end
    redirect_to foods_path
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  def format_food_name(name)
    formatted_name = name.strip.downcase.titleize.singularize
    formatted_name.gsub(/\s+/, '')
  end

  def update_existing_food(existing_food)
    if existing_food.is_deleted
      reactivate_and_update_food(existing_food)
    else
      update_food_quantity_and_price(existing_food)
    end
    redirect_to foods_path, notice: 'Food quantity and price were successfully updated.'
  end

  def reactivate_and_update_food(food)
    food.update(
      is_deleted: false,
      quantity: food_params[:quantity].to_i,
      price: food_params[:price].to_f
    )
  end

  def update_food_quantity_and_price(food)
    new_quantity, avg_price = calculate_new_quantity_and_price(food)
    food.update(quantity: new_quantity, price: avg_price)
  end

  def calculate_new_quantity_and_price(food)
    new_quantity = food.quantity + food_params[:quantity].to_i
    total_cost_old = food.price * food.quantity
    total_cost_new = food_params[:price].to_f * food_params[:quantity].to_i
    total_cost = total_cost_old + total_cost_new
    avg_price = total_cost / new_quantity
    [new_quantity, avg_price]
  end

  def create_new_food(formatted_name)
    @food = current_user.foods.build(food_params.merge(name: formatted_name))
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end
end
