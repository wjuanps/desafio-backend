FactoryBot.define do
  factory :invoice do
    document_number { rand(1...1_000_000) }
    provider { build(:provider) }
    document_type { 1 }
    deputy_id { 1 }
    deputy_quota_id { 1 }
  end
end
