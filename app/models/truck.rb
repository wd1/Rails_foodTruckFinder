class Truck < ApplicationRecord
  has_many :reviews
  has_many :items
  has_many :favorites
  has_many :users, through: :favorites
  has_many :schedules
  belongs_to :category
  belongs_to :location


  def rating
    if self.reviews.empty?
      nil
    else
      self.reviews.average(:rating).round(1)
    end
  end

  def self.favorite
    max_count = Truck.all.max_by{|truck| truck.users.count}.users.count
    trucks = Truck.all.select{|truck| truck.users.count == max_count}
    truck_names = trucks.collect{|truck| truck.name}.to_sentence
    has_have = trucks.count > 1 ? "have" : "has"
    it_them = trucks.count > 1 ? "them" : "it"
    "#{truck_names} #{has_have} been saved to favorites by the most users, with #{max_count} users having favorited #{it_them}!"
  end

  def self.zip_with_most_trucks
    #only returns first zip even if tied
    zips_array = Truck.all.collect{|tr| tr.location.zip}
    zips_hash = zips_array.inject(Hash.new(0)){|zip_codes, zip| zip_codes[zip] += 1; zip_codes}
    max_value = zips_hash.max_by{|k,v| v}
    max_key = zips_hash.key(max_value)
    "#{max_key} has the most foodtrucks with #{max_value} trucks!"
  end

  def self.highest_rated
    max_rating = Truck.all.max_by{|truck| truck.rating ? truck.rating : 0}.rating
    trucks = Truck.all.select{|truck| truck.rating == max_rating}
    truck_names = trucks.collect{|truck| truck.name}.to_sentence
    has_have = trucks.count > 1 ? "have" : "has"
    "#{truck_names} #{has_have} been rated highest by our users, with a rating of #{max_rating}!"
  end

  def pricey
    if self.items.empty?
      nil
    else
      avg = self.items.average(:price)

      if avg < 6
        1
      elsif avg < 10
        2
      elsif avg < 14
        3
      else
        4
      end
    end
  end

  def self.trucks_by_zip(zip)
    if zip
      Truck.all.select{|tr| tr.location.zip == zip}
    else
      Truck.all
    end
  end


  def self.url_generator(zip)
    # @trucks = Truck.all.select{|tr| tr.location.zip == zip}
    @trucks = self.trucks_by_zip(zip)
    key = "AIzaSyBcQBWJhUdprvVfhh4CAmwY7ixtNbaQGvc"
    url = <<-URL
      https://maps.googleapis.com/maps/api/staticmap?center=#{zip}&zoom=14&size=3000x300&maptype=roadmap&key=#{key}
    URL

    @trucks.each_with_index do |tr, i|
      address = tr.location.street_address.gsub(/ /, '+') + ',' + tr.location.city.gsub(/ /, '+')  + ',' + tr.location.state.gsub(/ /, '+')
      url += "&markers=color:red%7Clabel:#{i+1}%7C#{address}"
    end
    url.gsub(/[\s]+/,'')
  end

end
