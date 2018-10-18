FactoryBot.define do
  factory :user do
    name { Faker::Simpsons.character }
    email { "jbarlet@example.com" }
    address {"1600 Pennsylvania Ave NW, Washington, DC 20500"}
    phone {555555555}
    activated {0}
    password {"12345"}
  end
end
