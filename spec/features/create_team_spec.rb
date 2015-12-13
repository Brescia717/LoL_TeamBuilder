require 'rails_helper'

feature "Click on Create a Team" do
  scenario "Clicking on Create a Team from teams_path brings you to new_team_path" do
    team = FactoryGirl.build(:team)
    visit root_path

    click_on "Find Team"
    click_on "Create a Team"
    fill_in("About", with: team.about)

    click_on "Create Team"
    expect(page).to have_content("You need to sign in to create a team.")
  end

  scenario "If User is logged in, clicking on Create Team from new_team_path creates the team." do
    team = FactoryGirl.build(:team)
    user = FactoryGirl.create(:user)
    visit new_team_path

    click_on "Log In"
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Create a Team")

    fill_in("About", with: team.about)
    click_on "Create Team"

    expect(page).to have_content("#{user.summoner_name}'s Team")
  end
end
