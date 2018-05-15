require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "test_user"
      fill_in 'Password', :with => "biscuits"
      click_on "SignUp"
    end

    scenario "redirects to sign-in page after signup" do

      expect(page).to have_content "Welcome, test_user"
    end
  end

  feature "with an invalid user" do
    before(:each) do
      visit new_user_url
      fill_in 'Username', :with => "test_user"
      click_on "SignUp"
    end

    scenario "re-renders the new user page after failed signup" do
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

end
