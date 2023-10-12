class RecipeFoodsController < ApplicationController
  def index; end

  def show; end

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = Food.all
    @new_ingredient = RecipeFood.new
  end

  def create
    @new_ingredient = RecipeFood.new(recipe_food_params)
    if @new_ingredient.save
      flash[:notice] = 'The ingredient was added successfully!'
      redirect_to recipe_path(@new_ingredient.recipe_id)
    else
      flash[:alert] = 'The ingredient was not added, check if alreade exist!'
      redirect_to recipe_path(@new_ingredient.recipe_id)
    end
  end

  def edit; end

  def update
    @ingredient = RecipeFood.find(params[:id])
    if @ingredient.update(recipe_food_params)
      flash[:notice] = 'The ingredient was updated successfully!'
      redirect_to recipe_path(@ingredient.recipe_id)
    else
      flash[:alert] = 'The ingredient was not updated!'
      redirect_to recipe_path(@ingredient.recipe_id)
    end
  end

  def destroy
    @ingredient = RecipeFood.find(params[:id])
    if @ingredient.destroy
      flash[:notice] = 'The ingredient was deleted successfully!'
      redirect_to recipe_path(@ingredient.recipe_id)
    else
      flash[:alert] = 'The ingredient was not deleted!'
      redirect_to recipe_path(@ingredient.recipe_id)
    end
  end

  private 

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity, :recipe_id)
  end

end
