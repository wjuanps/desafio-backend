class Deputy < ApplicationRecord
  has_many :legislatures
  accepts_nested_attributes_for :legislatures
end
