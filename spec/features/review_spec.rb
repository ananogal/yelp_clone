require 'rails_helper'

describe 'While reviewing' do

	context 'while creating a review' do
		before do
			Restaurant.create(name: 'KFC')
			@ana = User.create(email: "ana@test.com", password: "password", password_confirmation: "password")
		end

		it 'should allow users to leave a review using a form' do
			visit '/'
			login_as @ana
			click_link 'Review KFC'
			fill_in "Thoughts", with: 'so so'
			select '3', from: 'Rating'
			click_button 'Leave Review'

			expect(current_path).to eq '/restaurants'
			expect(page).to have_content('so so')
		end

		it 'user must be logged in to leave a review' do
			visit '/'
			click_link "Review KFC"
			expect(current_path).to eq '/users/sign_in'
		end
	end

	context 'while deleting a review' do
		before do
			@ana = User.create(email: "ana@test.com", password: "password", password_confirmation: "password")
			login_as @ana
			@restaurant = @ana.restaurants.create(name: "KFC")
			@restaurant.reviews.create(thoughts: "blabla", rating: 3, user_id: @ana.id)
		end

		it 'user can delete the review if it has created it' do
			visit '/' 
			expect(page).to have_content "Delete"
		end

		it 'user can not delete a review if it didnt created' do
			@peter = User.create(email: "peter@test.com", password: "password", password_confirmation: "password")
			login_as @peter
			visit '/'
			expect(page).not_to have_content 'Delete'
		end

		it 'should delete a review' do
			visit '/'
			click_link "Delete"
			expect(page).not_to have_content 'blabla'
			expect(page).to have_content 'Review deleted successfully'
		end
	end

	context 'Average rating' do

		before do
			Restaurant.create(name: 'KFC')
			@ana = User.create(email: "ana@test.com", password: "password", password_confirmation: "password")
			@peter = User.create(email: "peter@test.com", password: "password", password_confirmation: "password")
		end

		it 'Displays an average rating for all reviews' do
			login_as @ana
			leave_review('soso', 3)
			logout
			login_as @peter
			leave_review('Great', 5)
			expect(page).to have_content "Average rating: ★★★★☆"
		end
	end

	def leave_review(thoughts, rating) 
		visit '/'
		click_link 'Review KFC'
		fill_in "Thoughts", with: thoughts
		select rating, from: "Rating"
		click_button "Leave Review"
	end

end
