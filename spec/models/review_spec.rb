require 'rails_helper'

RSpec.describe Review, :type => :model do
	it 'is invalid if the rating is more than 5'do
		review = Review.new(rating: 10)
		expect(review).to have(1).error_on(:rating)
	end

	it 'should only accept one review per user/restaurant' do
		@ana = User.create(email:"ana@test.com", password: "password", password_confirmation:"password")
		@restaurant = @ana.restaurants.create(name:"KFC")
		review = @ana.reviews.create(rating: 3, thoughts:"bla")
		review = @ana.reviews.create(rating: 2, thoughts:"bla bla")
		expect(Review.count).to eq(1) 
	end
end