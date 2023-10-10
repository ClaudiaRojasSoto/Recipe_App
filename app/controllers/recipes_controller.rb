class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipesData = Recipe.all
    @userOwner = current_user.id
  end

  def show
    @recipeData = Recipe.find(params[:id])
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
