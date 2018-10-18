require "rails_helper"

describe "When I create a User" do
  it "creates an API key" do
    user = User.create!(name: "Ben", email: "Ben@Ben.Ben", password: "Ben")

    expect(user.api_key.class).to be(String)
  end
end
