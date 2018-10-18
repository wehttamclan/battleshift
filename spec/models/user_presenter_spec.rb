require 'rails_helper'

RSpec.describe UserPresenter, type: :model do
  it "Should show user status" do
    attributes1 = { activated: 1,
                   id: 1,
                   name: "one",
                   email: "email@email.com"
                 }
    attributes2 = { activated: 0,
                   id: 1,
                   name: "one",
                   email: "email@email.com"
                 }
    user_1 = UserPresenter.new(attributes1)
    user_2 = UserPresenter.new(attributes2)

    expect(user_1.user_status).to eq("Status: Active")
    expect(user_2.user_status).to eq("This account has not yet been activated. Please check your email.")
  end
end
