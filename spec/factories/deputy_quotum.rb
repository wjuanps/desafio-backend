FactoryBot.define do
  factory :deputy_quotum do
    sub_quota_number { rand(1...1000000) }
    legislature_id { 1 }
  end
end
