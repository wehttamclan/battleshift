require 'rails_helper'

describe 'A guest user' do
  it 'visits User show page' do
    create(:user)

    visit '/users/1'

    expect(page).to have_css('.name')
    expect(page).to have_content('Josiah Bartlet')
    expect(page).to have_css('.email')
    expect(page).to have_css('.jbartlet@example.com')
  end
end