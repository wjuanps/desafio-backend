require 'sync/csv_data/util'

class Invoice < ApplicationRecord
  belongs_to :provider
  belongs_to :deputy
  belongs_to :deputy_quotum, class_name: 'DeputyQuotum', foreign_key: 'deputy_quota_id'
  validates :document_number, presence: true, allow_blank: false

  scope :get_invoices_by_deputy, -> (deputy_id) {
    includes(:provider).where(:deputy_id => deputy_id).order(net_value: :desc)
  }

  scope :total_expenses, -> {
    pluck(:net_value).sum
  }
  
  scope :get_years, -> {
    order(year: :desc).pluck(:year).uniq
  }
  
  scope :get_by_deputies, -> (invoices) {
    invoices.left_joins(:deputy)
             .group(:name)
             .group_by_year(:issue_date, format: '%Y')
             .sum(:net_value)
  }

  scope :get_months, -> (invoices) { invoices.pluck(:month).uniq }
  
  scope :maximum_expense, -> { pluck(:net_value).max }

  scope :get_monthly_expenses, -> (dataCharts) {
    dataCharts.group_by_month { |u| I18n.l([u["year"], u["month"], 1].join('-').to_date) }
               .to_h { |k, v| [k, v.map { |h| h["net_value"].to_f }.sum] }
  }

  scope :get_expenses_for, -> (entity, dataCharts) {
    dataCharts.group_by { |u| u[entity] }
               .to_h { |k, v| [k, v.map { |h| h["net_value"].to_f }.sum] }
  }

  def self.get_data_for_charts(legislatureCode, year, month, politicalParty, state, deputyTaxpayer, providerIdentifier)
    query = data_charts_query(legislatureCode, year, month, politicalParty, state, deputyTaxpayer, providerIdentifier)
    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.data_charts_query(legislatureCode, year, month, politicalParty, state, deputyTaxpayer, providerIdentifier)
    "
      select
        d.name as deputy_name,
        i.year as year,
        i.month as month,
        i.issue_date as issue_date,
        l.political_party as political_party,
        i.net_value as net_value,
        p.name as provider_name,
        dq.description as expense_type
      from deputies d
      left join legislatures l on d.id = l.deputy_id
      left join deputy_quota dq on l.id = dq.legislature_id
      left join invoices i on dq.id = i.deputy_quota_id
      left join providers p on p.id = i.provider_id
      where
        d.id = i.deputy_id
        and d.taxpayer like '%#{deputyTaxpayer}%'
        #{legislatureCode.present? ? "and l.legislature_code = #{legislatureCode}" : ''}
        #{year.present? ? "and TO_CHAR(i.issue_date, 'YYYY') = '#{year}'" : ''}
        #{month.present? ? "and TO_CHAR(i.issue_date, 'YYYY/MM') = '#{year}/#{month.to_s.rjust(2, '0')}'" : ''}
        #{politicalParty.present? ? "and l.political_party = '#{politicalParty}'" : ''}
        #{state.present? ? "and l.state = '#{state}'" : ''}
        #{providerIdentifier.present? ? "and p.provider_identifier = '#{providerIdentifier}'" : ''}
    ".freeze
  end
end
