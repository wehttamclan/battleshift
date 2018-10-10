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

    within(first(".user")) do
      expect(page).to have_css('.name')
      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_css('.email')
      expect(page).to have_content('jbarlet@example.com')
    end
  end
  it 'updates a users email' do
    visit '/users'

    within(first(".user")) do
      click_on 'Edit'
    end

    expect(current_path).to eq '/users/1/edit'

    fill_in 'Email', with: 'josiah@example.com'

    click_on 'Save'

    expect(current_path).to eq '/users'

    expect(page).to have_content "Successfully updated Josiah Bartlet."
    
    expect(page).to have_content 'josiah@example.com'
    expect(page).to_not have_content 'jbarlet@example.com'
  end
end