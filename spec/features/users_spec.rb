require 'rails_helper'

describe 'A guest user' do
  it 'visits User show page' do
    visit "/users/1"

    expect(page).to have_css('.name')
    expect(page).to have_content('Name: Josiah Bartlet')
    expect(page).to have_css('.email')
    expect(page).to have_content('Email: jbarlet@example.com')
  end
  it 'visits User index page' do
    visit "/users"

    expect(page).to have_css(".user", count: 1)
    within(first(".user")) do
      expect(page).to have_css('.name')
      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_css('.email')
      expect(page).to have_content('jbarlet@example.com')
    end
  end
end