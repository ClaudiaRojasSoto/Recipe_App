class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods
  # has_and_belongs_to_many :foods, join_table: 'recipe_foods'

  scope :active, -> { where(is_deleted: false) }

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def self.obtener_precio(name)
    puts "Obteniendo precio para: #{name}"
    food = Food.find_by(name: name)
    price = food ? food.price : 0
    puts "Precio obtenido: #{price}"
    price
  end
end
