require 'rails_helper'

describe 'A guest user' do
  it 'visits User show page' do
    VCR.use_cassette("visit user show page") do
      visit "/users/1"
    end
      expect(page).to have_css('.name')
      expect(page).to have_content('Name: Josiah Bartlet')
      expect(page).to have_css('.email')
      expect(page).to have_content('Email: jbarlet@example.com')
  end
  it 'visits User index page' do
    VCR.use_cassette("visit user index page") do
      visit "/users"
    end

    within(first(".user")) do
      expect(page).to have_css('.name')
      expect(page).to have_content('Josiah Bartlet')
      expect(page).to have_css('.email')
      expect(page).to have_content('jbarlet@example.com')
    end
  end
  it 'updates a users email' do
    create(:user)
    VCR.use_cassette("visit user index page") do
      visit '/users'
    end

    within(first(".user")) do
      VCR.use_cassette("click edit from user index") do
        click_on 'Edit'
      end
    end

    expect(current_path).to eq '/users/1/edit'

    fill_in 'email', with: 'josiah@example.com'

    VCR.use_cassette("edit save", :allow_unused_http_interactions => false) do
      click_on 'Save'
    end

    expect(current_path).to eq '/users'

    expect(page).to have_content "Successfully updated Josiah Bartlet."

    expect(page).to have_content 'josiah@example.com'
    expect(page).to_not have_content 'jbarlet@example.com'
  end
end
