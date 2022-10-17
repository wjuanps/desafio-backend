FactoryBot.define do
  factory :legislature do
    legislature_number { rand(1...10_000_000) }
    legislature_code { rand(1...10_000_000) }
    deputy_id { 1 }
  end
end
