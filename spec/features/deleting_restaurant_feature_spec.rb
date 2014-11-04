require 'rails_helper'

describe 'Deleting restaurant' do

	context 'when logged in' do
		before do
			@ana = User.create(email: "ana@test.com", password:"12345678", password_confirmation:"12345678")
			login_as @ana
			@ana.restaurants.create(name:"KFC")
		end

		it 'removes a restaurant when a user clicks a delete link' do
			visit '/restaurants'
			click_link "Delete KFC"
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content 'Restaurant deleted successfully'
		end
	end

	context 'when login as another user' do
		before do
			@ana = User.create(email: "ana@test.com", password:"12345678",  password_confirmation:"12345678")
			@peter = User.create(email: "peter@test.com", password:"12345678", password_confirmation: "12345678")
			@ana.restaurants.create(name:"KFC")
		end

		it "can not delete a restaurant if it's not his own" do 
			visit '/'
			login_as @peter
			expect(page).not_to have_content 'Delete KFC'
		end
	end
end