FactoryBot.define do
  factory :deputy do
    deputy_identifier { rand(1...10_000_000) }
    taxpayer { '553.006.780-82' }
    name { 'Ruan Soares' }
  end
end
