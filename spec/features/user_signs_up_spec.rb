require 'rails_helper'

feature "User signs up" do
  scenario "User submits correct data" do
    user = FactoryGirl.build(:user)
    visit root_path

    click_on "Sign Up"
    fill_in('Email', with: user.email)
    fill_in('Username', with: user.username)
    fill_in('Summoner name', with: user.summoner_name)
    fill_in('Primary role', with: user.primary_role)
    fill_in('Secondary role', with: user.secondary_role)
    fill_in('Password', with: user.password)
    fill_in('Password confirmation', with: user.password)

    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
