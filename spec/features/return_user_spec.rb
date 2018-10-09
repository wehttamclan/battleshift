require 'rails_helper'

describe "As a guest user" do
  scenario "visiting specific user" do
  visit "/users/1"

  expect(page).to have_content("Josiah Bartlet")
  expect(page).to have_content("jbartlet@example.com")
  end
end
