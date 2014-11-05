class Restaurant < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	validates :name, length: {minimum: 3}, uniqueness: true
	belongs_to :user

	def average_rating
		return 'N/A' if reviews.none?
		Review.average(:rating)
	end

end
