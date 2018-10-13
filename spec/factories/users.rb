FactoryBot.define do
  factory :user do
    name {"Josiah Bartlet"}
    email { "jbarlet@example.com" }
    address {"1600 Pennsylvania Ave NW, Washington, DC 20500"}
    phone {555555555}
    password {"12345"}
  end
end
