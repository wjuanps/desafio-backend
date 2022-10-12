class Legislature < ApplicationRecord
  belongs_to :deputy
  has_many :quotas
  accepts_nested_attributes_for :quotas
end
