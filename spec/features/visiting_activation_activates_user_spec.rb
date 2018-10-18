require 'rails_helper'

RSpec.describe ActivateController, type: :controller do

  describe "Visit activation link" do
    before :each do
      @user = create(:user)
    end

    it "Activates user" do
      expect(@user.activated).to eq("inactive")

      VCR.use_cassette("activating account and redirecting to dashboard100000") do
        visit "/activation?api_key=#{@user.api_key}"
      end

      expect(current_path).to eq("/dashboard")
    end

    it "redirects to dashboard" do
      VCR.use_cassette("activating account and redirecting to dashboard111110") do
        visit "/dashboard"
      end

      expect(current_path).to eq("/dashboard")
      binding.pry
      expect(@user.activated).to eq("active")
    end
  end
end
