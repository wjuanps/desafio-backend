FactoryBot.define do
  factory :provider do
    name { 'Ruan Soares' }
    provider_identifier { rand(1...1_000_000) }
  end
end
