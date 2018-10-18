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
  end
end
