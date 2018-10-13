require 'rails_helper'

describe "I Successfully make an account" do
  describe "User clicks activation link" do
    it "should activate account" do

    end
  end
end

# Background: The registration process will trigger this story
#
# As a non-activated user
# When I check my email for the registration email
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
