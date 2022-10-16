require 'sync/csv_data/util'

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]
  before_action :set_util, only: %i[ index ]

  # GET /invoices or /invoices.json
  def index
    @legislatureCode = params[:legislatureCode]
    @year = params[:year].present? ? params[:year] : 2021
    @month = params[:month]
    @politicalParty = params[:politicalParty]
    @state = params[:state]
    @deputyTaxpayer = params[:deputyTaxpayer]
    @providerIdentifier = params[:providerIdentifier]

    @politicalParties = Legislature.get_political_parties
    @legislatureCodes = Legislature.get_legislature_codes
    @states = Legislature.get_states
    @years = Invoice.get_years
    @deputies = Deputy.get_list_deputies('', @year)
    @providers = Provider.get_list_providers

    @data = Invoice.get_data_for_charts(@legislatureCode,
                                        @year,
                                        @month,
                                        @politicalParty,
                                        @state,
                                        @deputyTaxpayer,
                                        @providerIdentifier)

    if @month.nil? || @month.empty?
      @monthlyExpenses = Invoice.get_monthly_expenses(@data)
    end

    if @month.present?
      @dailyExpenses = Invoice.get_expenses_for("issue_date", @data)
    end

    @politicalPartyExpenses = Invoice.get_expenses_for("political_party", @data)
    @providerExpenses = Invoice.get_expenses_for("provider_name", @data)
    @typeExpenses = Invoice.get_expenses_for("expense_type", @data)
    @deputyExpenses = Invoice.get_expenses_for("deputy_name", @data)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
  
  def set_util
    @util = Sync::CSV_DATA::Util.new
  end
end
