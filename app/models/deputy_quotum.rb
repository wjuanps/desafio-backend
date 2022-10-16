class DeputyQuotum < ApplicationRecord
  belongs_to :legislature
  has_many :invoices, class_name: 'Invoice', foreign_key: 'deputy_quota_id'
end
