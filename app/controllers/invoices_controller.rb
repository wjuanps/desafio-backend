require 'sync/csv_data/util'

class InvoicesController < ApplicationController

  before_action :set_invoice, only: %i[show edit update destroy]
  before_action :set_util, only: %i[index]

  before_action :set_filter, only: %i[index]
  before_action :fetch_data_charts, only: %i[index]
  before_action :fetch_political_parties, only: %i[index]
  before_action :fetch_legislature_codes, only: %i[index]
  before_action :fetch_states, only: %i[index]
  before_action :fetch_years, only: %i[index]
  before_action :fetch_deputies, only: %i[index]
  before_action :fetch_providers, only: %i[index]
  before_action :fetch_monthly_expenses, only: %i[index]
  before_action :fetch_daily_expenses, only: %i[index]
  before_action :fetch_political_party_expenses, only: %i[index]
  before_action :fetch_provider_expenses, only: %i[index]
  before_action :fetch_type_expenses, only: %i[index]
  before_action :fetch_deputy_expenses, only: %i[index]

  # GET /invoices or /invoices.json
  def index; end

  private

  def set_filter
    @filter = {
      legislature_code: params[:legislature_code],
      year: params[:year].present? ? params[:year] : 2021,
      month: params[:month],
      political_party: params[:political_party],
      state: params[:state],
      deputy_taxpayer: params[:deputy_taxpayer],
      provider_identifier: params[:provider_identifier]
    }
  end

  def fetch_data_charts
    @data_charts = Invoice.get_data_for_charts(@filter)
  end

  def fetch_political_parties
    @political_parties = Legislature.get_political_parties
  end

  def fetch_legislature_codes
    @legislature_codes = Legislature.get_legislature_codes
  end

  def fetch_states
    @states = Legislature.get_states
  end

  def fetch_years
    @years = Invoice.get_years
  end

  def fetch_deputies
    @deputies = Deputy.get_list_deputies('', @filter[:year])
  end

  def fetch_providers
    @providers = Provider.get_list_providers
  end

  def fetch_monthly_expenses
    @monthly_expenses = Invoice.get_monthly_expenses(@data_charts) if @filter[:month].nil? || @filter[:month].empty?
  end

  def fetch_daily_expenses
    @daily_expenses = Invoice.get_expenses_for('issue_date', @data_charts) if @filter[:month].present?
  end

  def fetch_political_party_expenses
    @political_party_expenses = Invoice.get_expenses_for('political_party', @data_charts)
  end

  def fetch_provider_expenses
    @provider_expenses = Invoice.get_expenses_for('provider_name', @data_charts)
  end

  def fetch_type_expenses
    @type_expenses = Invoice.get_expenses_for('expense_type', @data_charts)
  end

  def fetch_deputy_expenses
    @deputy_expenses = Invoice.get_expenses_for('deputy_name', @data_charts)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_util
    @util = Sync::CSVData::Util.new
  end

end
