class Neighborhood < ApplicationRecord
  has_many :locations
  has_many :trucks, through: :locations
end
