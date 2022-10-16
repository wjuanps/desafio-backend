class Provider < ApplicationRecord
  has_many :invoices
  validates :name, :provider_identifier, presence: true, allow_blank: false

  scope :get_list_providers, -> {
    all().order(name: :asc)
  }
end
