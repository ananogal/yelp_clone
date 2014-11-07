require 'rails_helper'

describe 'restaurants' do 
	before do
		@ana = User.create(email: "ana@test.com", password:"12345678",  password_confirmation:"12345678")
	end 

	context 'no restaurants have been added' do 
		it 'should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name:'KFC')
		end

		it 'should display restaurants' do
			visit'/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
	end

	context 'creating restaurants' do

		it 'prompts user to fill out a form, then displays the new restaurant' do
			visit '/restaurants'
			login_as @ana
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		context 'an invalid restaurant' do
			it 'does not let you submit a name that is too short' do
				visit '/restaurants'
				login_as @ana
				click_link 'Add a restaurant'
				fill_in 'Name', with: 'kf'
				click_button 'Create Restaurant'
 				expect(page).not_to have_css 'h2', text: 'kf'
 				expect(page).to have_content 'error'
			end
		end	
	end

	context 'When a user is not logged in' do
		it "can't create a restaurant" do
			visit '/'
			click_link 'Add a restaurant'
			expect(current_path).to eq '/users/sign_in'
		end

	end

	context 'viewing restaurants' do
		before do
			@kfc = Restaurant.create(name:'KFC')
		end

		it 'lets a user view a restaurant' do 
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{@kfc.id}"
		end
	end

end