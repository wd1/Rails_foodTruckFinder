class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :truck

  validates_uniqueness_of :user_id, scope: :truck_id
end
