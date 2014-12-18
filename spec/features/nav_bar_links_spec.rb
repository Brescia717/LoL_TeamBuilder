require 'rails_helper'

feature "Click on Home button" do
  scenario "Clicking on Home button brings you to root_path" do
    visit teams_path

    click_on "Home"
    expect(page).to have_content("Welcome to LoL TeamBuilder!")
  end
end

feature "Click on Find Team button" do
  scenario "Clicking on Find Team button brings you to teams_path" do
    visit root_path

    click_on "Find Team"
    expect(page).to have_content("Featured Teams")
  end
end

feature "Click on Log In button" do
  scenario "Clicking on Log In button brings you to new_user_session_path" do
    visit root_path

    click_on "Log In"
    expect(page).to have_content("Forgot your password?")
  end
end

feature "Click on Sign Up button" do
  scenario "Clicking on Sign Up button brings you to new_user_registration_path" do
    visit root_path

    click_on "Sign Up"
    expect(page).to have_content("Password confirmation")
  end
end

feature "Click on LoLTeamBuilder button" do
  scenario "Clicking on LoLTeamBuilder button brings you to root_path" do
    visit teams_path

    click_on "LoLTeamBuilder"
    expect(page).to have_content("Welcome to LoL TeamBuilder!")
  end
end
