class Review < ApplicationRecord
  belongs_to :user
  belongs_to :truck

  validates :title, presence: true
  validates :content, presence: true
  validates :rating, presence: true, :inclusion => {:in => [1,2,3,4,5]}
  validates :truck_id, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :truck_id

end
