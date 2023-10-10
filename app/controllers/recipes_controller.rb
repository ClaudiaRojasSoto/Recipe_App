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
end
