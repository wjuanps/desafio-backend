class Legislature < ApplicationRecord

  belongs_to :deputy
  has_many :deputy_quota
  validates :legislature_number, :legislature_code, presence: true, allow_blank: false

  scope :get_political_parties, lambda {
    all.order(political_party: :asc).pluck(:political_party).uniq
  }

  scope :get_legislature_codes, lambda {
    all.order(legislature_code: :desc).pluck(:legislature_code).uniq
  }

  scope :get_states, lambda {
    all.order(state: :asc).pluck(:state).uniq
  }

  scope :get_current_legislature_by_deputy, lambda { |deputy_id|
    where(deputy_id: deputy_id).order(legislature_code: :desc).first
  }

end
