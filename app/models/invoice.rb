require 'sync/csv_data/util'

class Invoice < ApplicationRecord

  belongs_to :provider
  belongs_to :deputy
  belongs_to :deputy_quotum, class_name: 'DeputyQuotum', foreign_key: 'deputy_quota_id'
  validates :document_number, presence: true, allow_blank: false

  scope :get_invoices_by_deputy, lambda { |deputy_id|
    includes(:provider).where(deputy_id: deputy_id).order(net_value: :desc)
  }

  scope :total_expenses, lambda {
    pluck(:net_value).sum
  }

  scope :get_years, lambda {
    order(year: :desc).pluck(:year).uniq
  }

  scope :get_by_deputies, lambda { |invoices|
    invoices.left_joins(:deputy)
      .group(:name)
      .group_by_year(:issue_date, format: '%Y')
      .sum(:net_value)
  }

  scope :get_months, ->(invoices) { invoices.pluck(:month).uniq }

  scope :maximum_expense, -> { pluck(:net_value).max }

  scope :get_monthly_expenses, lambda { |data_charts|
    data_charts.group_by_month { |u| I18n.l([u['year'], u['month'], 1].join('-').to_date) }
      .to_h { |k, v| [k, v.map { |h| h['net_value'].to_f }.sum] }
  }

  scope :get_expenses_for, lambda { |entity, data_charts|
    data_charts.group_by { |u| u[entity] }
      .to_h { |k, v| [k, v.map { |h| h['net_value'].to_f }.sum] }
  }

  def self.get_data_for_charts(chart_params)
    query = data_charts_query(chart_params)

    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.data_charts_query(chart_params)
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
        #{deputy_taxpayer_statement(chart_params)}
        #{legislature_code_statement(chart_params)}
        #{year_statement(chart_params)}
        #{month_statement(chart_params)}
        #{political_party_statement(chart_params)}
        #{state_statement(chart_params)}
        #{provider_identifier_statement(chart_params)}
    ".freeze
  end

  def self.deputy_taxpayer_statement(chart_params)
    "and d.taxpayer like '%#{chart_params[:deputy_taxpayer]}%'"
  end

  def self.legislature_code_statement(chart_params)
    chart_params[:legislature_code].present? ? "and l.legislature_code = #{chart_params[:legislature_code]}" : ''
  end

  def self.year_statement(chart_params)
    chart_params[:year].present? ? "and TO_CHAR(i.issue_date, 'YYYY') = '#{chart_params[:year]}'" : ''
  end

  def self.month_statement(chart_params)
    month = "'#{chart_params[:year]}/#{chart_params[:month].to_s.rjust(2, '0')}'".to_s

    chart_params[:month].present? ? "and TO_CHAR(i.issue_date, 'YYYY/MM') = #{month}" : ''
  end

  def self.political_party_statement(chart_params)
    chart_params[:political_party].present? ? "and l.political_party = '#{chart_params[:political_party]}'" : ''
  end

  def self.state_statement(chart_params)
    chart_params[:state].present? ? "and l.state = '#{chart_params[:state]}'" : ''
  end

  def self.provider_identifier_statement(chart_params)
    chart_params[:provider_identifier].present? ? "and p.provider_identifier = '#{chart_params[:provider_identifier]}'" : ''
  end

end
