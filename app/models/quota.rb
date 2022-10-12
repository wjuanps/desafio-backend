class Quota < ApplicationRecord
  belongs_to :legislature
  has_many :invoices
  accepts_nested_attributes_for :invoices
end
