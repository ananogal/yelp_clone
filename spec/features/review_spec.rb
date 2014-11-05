require 'rails_helper'

describe 'user reviewing' do

	context 'creating a review' do
		before do
			Restaurant.create(name: 'KFC')
			@ana = User.create(email: "ana@test.com", password: "password", password_confirmation: "password")
		end

		it 'allows users to leave a review using a form' do
			visit '/'
			login_as @ana
			click_link 'Review KFC'
			fill_in "Thoughts", with: 'so so'
			select '3', from: 'Rating'
			click_button 'Leave Review'

			expect(current_path).to eq '/restaurants'
			expect(page).to have_content('so so')
		end

		it 'user must be logged in' do
			visit '/'
			click_link "Review KFC"
			expect(current_path).to eq '/users/sign_in'
		end
	end

end
