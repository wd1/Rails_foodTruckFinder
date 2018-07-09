class User < ApplicationRecord
  has_many :reviews
  has_many :favorites
  has_many :trucks, through: :favorites
  has_many :schedules
  belongs_to :location

  validates :username, uniqueness: true
  validates :username, format: {with: /\A[a-zA-Z0-9]+\Z/}
  validates :email, uniqueness: true
  validates :username, :email, :f_name, :l_name, presence: true
  validates :password, length: { minimum: 6 }
  # validates_email_format_of :email
  validates_format_of :email, :with => /@/

  has_secure_password
  accepts_nested_attributes_for :location

  def full_name
    "#{self.f_name} #{self.l_name}"
  end

  def get_rating(truck)
    review = Review.where("truck_id = ? and user_id = ?", truck.id, self.id).first
    review ? review.rating : 0
  end

  def cleanup
    Favorite.where("user_id = ?", self.id).destroy_all
    Review.where("user_id = ?", self.id).destroy_all
    Location.where("id = ?", self.location_id).destroy_all
  end

  def self.user_exist(username)
    User.find_by(username: username)
  end

  def self.how_many
    "Food Truck Tracker has #{User.all.count} active users"
  end

  def self.most_reviews
    user = User.all.max_by {|user| user.reviews.count}
    total_reviews = user.reviews.count
    "#{user.username} has written the most reviews, with #{total_reviews} reviews"
  end

end
