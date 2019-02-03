require 'rails_helper'

RSpec.feature "Auths", type: :feature do

  feature 'the signup process' do
    scenario 'has a new user page' do
      visit new_user_url
      expect(page).to have_content 'New User'
    end

    feature 'signing up a user' do

      before(:each) do
        visit new_user_url
        fill_in 'Username', with: 'Billy'
        fill_in 'Password', with: 'password'
        click_on 'Sign Up'
      end

      scenario 'shows username on the user show page after signup' do
        expect(page).to have_content 'Billy'
      end
    end
  end

  feature 'logging in' do
    before(:each) do
      user = User.create!(username: "Billy", password: "password")
    end

    scenario 'with correct credentials' do    
      visit new_session_url
      fill_in 'Username', with: 'Billy'
      fill_in 'Password', with: 'password'
      click_on 'Sign In'
      expect(page).to have_content 'Billy'
    end
    
    scenario 'with incorrect credentials' do
      visit new_session_url
      fill_in 'Username', with: 'Billy'
      fill_in 'Password', with: '98765432'
      click_on 'Sign In'
      expect(page).to have_content 'Invalid Credentials'
    end
  end

  feature 'logging out' do
    scenario 'begins with a logged out state' do
      visit users_url
      expect(page).to have_content 'Log In'
    end

    scenario 'doesn\'t show username on the homepage after logout' do 
      visit new_session_url
      fill_in 'Username', with: 'Billy'
      fill_in 'Password', with: 'password'
      click_on 'Sign In'
      save_and_open_page
      click_on 'Sign Out'


      expect(page).to have_content 'Log In'
    end

  end
end
