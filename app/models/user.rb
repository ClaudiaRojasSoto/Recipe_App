class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :foods
  has_many :recipes

  validates :name, presence: true

  def foods_all_recipes
    foods = []
    recipes.each do |recipe|
      recipe.foods.each do |food|
        foods << food
      end
    end
    foods
  end
end
