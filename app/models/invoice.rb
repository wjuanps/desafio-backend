require 'sync/csv_data/util'

class Invoice < ApplicationRecord

  belongs_to :provider
  belongs_to :deputy
  belongs_to :deputy_quotum, class_name: 'DeputyQuotum', foreign_key: 'deputy_quota_id'
  validates :document_number, presence: true, allow_blank: false

  # Workaround to handling with special caracters. I'd like to use the unaccent
  # method, but I haven't found a way to do it with docker
  TRANSLATE_FROM = 'ÁÀÂÃÄáàâãäÉÈÊËéèêëÍÌÎÏíìîïÓÒÕÔÖóòôõöÚÙÛÜúùûüÇç'.freeze
  TRANSLATE_TO = 'AAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUUuuuuÇc'.freeze

  scope :total_expenses, lambda {
    pluck(:net_value).sum
  }

  scope :get_years, lambda {
    order(year: :desc).pluck(:year).uniq
  }

  scope :maximum_expense, -> { pluck(:net_value).max }

  scope :get_monthly_expenses, lambda { |data_charts|
    data_charts.group_by_month { |u| u['issue_date'] }
      .to_h { |k, v| [k, v.map { |h| h['net_value'].to_f }.sum] }
  }

  scope :get_expenses_for, lambda { |entity, data_charts|
    data_charts.group_by { |u| u[entity] }
      .to_h { |k, v| [k, v.map { |h| h['net_value'].to_f }.sum] }
  }

  scope :get_deputy_expenses, lambda { |params|
    joins(:provider)
      .where("deputy_id = #{params[:deputy_id]} #{deputy_expenses_filter(params)}")
      .order(net_value: :desc)
  }

  def self.get_data_for_charts(params)
    query = data_charts_query(params)

    ActiveRecord::Base.connection.exec_query(query)
  end

  def self.data_charts_query(params)
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
        #{deputy_taxpayer_statement(params)}
        #{legislature_code_statement(params)}
        #{year_statement(params)}
        #{month_statement(params)}
        #{political_party_statement(params)}
        #{state_statement(params)}
        #{provider_identifier_statement(params)}
    ".freeze
  end

  def self.deputy_expenses_filter(params)
    if params[:deputy_id].present?
      return "
        and (
          cast(invoices.document_number as text) like '%#{params[:document_number]}%'
          and translate(lower(providers.name), '#{TRANSLATE_FROM}', '#{TRANSLATE_TO}') like (
            '%#{ActiveSupport::Inflector.transliterate(params[:provider_name]).downcase}%'
          )
          #{params[:net_value].present? ? 'and invoices.net_value*100 ' "#{params[:net_value_type]} #{params[:net_value]}" : ''}
          #{issue_date_statement(params)}
        )
      ".freeze
    end

    ''
  end

  def self.deputy_taxpayer_statement(params)
    "and d.taxpayer like '%#{params[:deputy_taxpayer]}%'"
  end

  def self.legislature_code_statement(params)
    params[:legislature_code].present? ? "and l.legislature_code = #{params[:legislature_code]}" : ''
  end

  def self.year_statement(params)
    params[:year].present? ? "and TO_CHAR(i.issue_date, 'YYYY') = '#{params[:year]}'" : ''
  end

  def self.month_statement(params)
    month = "'#{params[:year]}/#{params[:month].to_s.rjust(2, '0')}'".to_s

    params[:month].present? ? "and TO_CHAR(i.issue_date, 'YYYY/MM') = #{month}" : ''
  end

  def self.political_party_statement(params)
    params[:political_party].present? ? "and l.political_party = '#{params[:political_party]}'" : ''
  end

  def self.state_statement(params)
    params[:state].present? ? "and l.state = '#{params[:state]}'" : ''
  end

  def self.provider_identifier_statement(params)
    params[:provider_identifier].present? ? "and p.provider_identifier = '#{params[:provider_identifier]}'" : ''
  end

  def self.issue_date_statement(params)
    statement = "and invoices.issue_date between '#{params[:issue_date_start]}'" 'and ' "'#{params[:issue_date_end]}'".freeze
    return statement if params[:issue_date_start].present? && params[:issue_date_end].present?

    statement = "and invoices.issue_date >= '#{params[:issue_date_start]}'".freeze
    return statement if params[:issue_date_start].present? && params[:issue_date_end].nil?

    ''
  end

end
