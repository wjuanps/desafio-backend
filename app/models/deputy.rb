class Deputy < ApplicationRecord
  has_many :legislatures
  has_many :invoices
  validates :name, :deputy_identifier, :taxpayer, presence: true, allow_blank: false
  validates :taxpayer, :deputy_identifier, uniqueness: true

  # Workaround to handling with special caracters. I'd like to use the unaccent
  # method, but I haven't found a way to do it with docker
  TRANSLATE_FROM = 'ÁÀÂÃÄáàâãäÉÈÊËéèêëÍÌÎÏíìîïÓÒÕÔÖóòôõöÚÙÛÜúùûüÇç'.freeze
  TRANSLATE_TO = 'AAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUUuuuuÇc'.freeze

  scope :get_list_deputies, -> (deputy_name, year) {
    left_joins(:invoices)
      .includes(:legislatures)
      .where("translate(lower(name), '#{TRANSLATE_FROM}', '#{TRANSLATE_TO}') like ? and invoices.year = ?",
              "%#{ActiveSupport::Inflector.transliterate(deputy_name).downcase}%",
               year)
      .order(name: :asc)
      .distinct
  }

  scope :get_deputy, -> (deputy_id) {
    includes(:legislatures).find_by(id: deputy_id)
  }

  def get_name
    ActiveSupport::Inflector.transliterate(self.name).gsub(/\s/, '-').downcase
  end

  def photo_url
    "http://www.camara.leg.br/internet/deputado/bandep/#{self.deputy_identifier}.jpg"
  end
end
