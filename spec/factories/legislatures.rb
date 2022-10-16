FactoryBot.define do
  factory :legislature do
    legislature_number { rand(1...10000000) }
    legislature_code { rand(1...10000000) }
    deputy_id { 1 }
  end
end
