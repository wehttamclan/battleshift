require 'rails_helper'

RSpec.describe ActivateController, type: :controller do
  describe "it should activate a user" do
    it "Activates user" do
      user = create(:user)

      VCR.use_cassette("activating account and redirecting to dashboard3", :allow_unused_http_interactions => false) do
        visit "/activation?api_key=#{user.api_key}"
      end

      expect(current_path).to eq("/dashboard")
      expect(user.activated).to eq("active")
    end
  end
end
