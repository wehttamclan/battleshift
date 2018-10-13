require "rails_helper"


describe "As a guest User" do
  describe "I can visit the root and register an account" do
    it "Should let me register and redirect to my dashboard" do
      # As a guest user
      # When I visit "/"
      visit "/"
      # And I click "Register"
      click_on "Register"
      # Then I should be on "/register"
      expect(current_path).to eq("/register")
      # And when I fill in an email address (required)
      fill_in 'email', with: 'stalin@example.com'
      # And I fill in name (required)
      fill_in 'name', with: 'Brayden'
      # And I fill in password and password confirmation (required)
      fill_in 'password', with: '12345'
      fill_in 'password_confirmation', with: '12345'
      # And I click submit
      VCR.use_cassette("create user", :allow_unused_http_interactions => false) do
        click_on "Submit"
      end
      # Then I should be redirected to "/dashboard"
      expect(current_path).to eq("/dashboard")
      # And I should see a message that says "Logged in as <SOME_NAME>"
      expect(page).to have_content("Logged in as Brayden")
      # And I should see "This account has not yet been activated. Please check your email."
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end
