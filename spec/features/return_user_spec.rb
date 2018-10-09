require 'rails_helper'

describe "As a guest user" do
  scenario "visiting specific user" do
    visit "/users/1"

    expect(page).to have_content("Name: Josiah Bartlet")
    expect(page).to have_content("Email: jbartlet@example.com")
  end
  scenario "visiting all users, there should be two" do
    visit "/users"
    # Then I should see the user's name (for both users)
    expect(page).to have_css(".user", count: 2)
    expect(page).to have_content("Josiah Bartlet")
    expect(page).to have_content("jbartlet@example.com")
    expect(page).to have_content("Ben Jammin")
    expect(page).to have_content("benjammin@example.com")
    # And I should see the user's email (for both users)
  end
end
