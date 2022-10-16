FactoryBot.define do
  factory :provider do
    name { "Ruan Soares" }
    provider_identifier { rand(1...1000000) }
  end
end
