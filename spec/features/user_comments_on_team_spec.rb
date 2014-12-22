require 'rails_helper'

feature "User visits team page, fills out comment, and submits." do
  scenario "Filling out 'body' and clicking Create Comment successful." do
    user = FactoryGirl.create(:user)
    team = FactoryGirl.build(:team)
    comment = FactoryGirl.build(:comment)
    visit teams_path

    click_on "Log In"
    fill_in("Username", with: user.username)
    fill_in("Password", with: user.password)
    click_on "Log in"

    click_on "Create a Team"
    fill_in("About", with: team.about)
    # click_on "Create Team"

    # fill_in('Body', with: comment.body)
    #
    # click_on "Create Comment"
    # expect(page).to have_content("You have successfully posted your comment.")
  end
end
