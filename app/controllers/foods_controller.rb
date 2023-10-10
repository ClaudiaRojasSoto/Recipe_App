class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = if params[:sort] == 'name'
               current_user.foods.order('LOWER(name)')
             else
               current_user.foods
             end
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    if @food.destroy
      flash[:notice] = 'Food was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete food!'
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
end
