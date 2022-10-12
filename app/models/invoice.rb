class Invoice < ApplicationRecord
  belongs_to :quota
  has_one :provider
end
