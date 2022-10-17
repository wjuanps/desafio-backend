require 'sync/csv_data/synchronizer'
require 'sync/csv_data/util'
require 'csv'

class DeputiesController < ApplicationController

  before_action :authenticate_user!, only: %i[create new]
  before_action :set_page, only: %i[show index]
  before_action :set_util, only: %i[show index]

  before_action :set_deputy, only: %i[show]
  before_action :set_filter, only: %i[show]
  before_action :set_invoices, only: %i[show]
  before_action :set_total_expenses, only: %i[show]
  before_action :set_current_legislature, only: %i[show]
  before_action :set_max_expense, only: %i[show]

  # GET /deputies or /deputies.json
  def index
    @deputy_name = params[:deputy_name].present? ? params[:deputy_name] : ''
    @year = params[:year].present? ? params[:year] : 2021
    @deputies = Deputy.get_list_deputies(@deputy_name, @year).page(@page).per(6)
  end

  # GET /deputies/1 or /deputies/1.json
  def show; end

  # GET /deputies/new
  def new
    @deputy = Deputy.new
  end

  # POST /deputies or /deputies.json
  def create
    file = params[:deputy][:file]

    synchronizer = Sync::CSVData::Synchronizer.new
    sync = synchronizer.sync(file)

    if sync[:error]
      redirect_back(fallback_location: deputies_new_path, notice: sync[:message])
    else
      redirect_to root_path, notice: sync[:message]
    end
  end

  private

  def set_deputy
    @deputy = Deputy.find_by_id(params[:id])

    redirect_to root_path, notice: 'Deputado não encontrado' unless @deputy.present?
  end

  def set_invoices
    @invoices = Invoice.get_deputy_expenses(@filter).page(@page).per(10)
  end

  # rubocop:disable Metrics/AbcSize
  def set_filter
    @filter = {
      deputy_id: @deputy.id,
      document_number: params[:document_number],
      provider_name: params[:provider_name].present? ? params[:provider_name] : '',
      issue_date_start: params[:issue_date_start].present? ? params[:issue_date_start].to_date : nil,
      issue_date_end: params[:issue_date_end].present? ? params[:issue_date_end].to_date : nil,
      net_value: params[:net_value].present? ? params[:net_value].to_i : nil,
      net_value_type: params[:net_value_type]
    }.freeze
  end
  # rubocop:enable Metrics/AbcSize

  def set_total_expenses
    @total_expenses = @util.convert_cents_to_real(@deputy.invoices.total_expenses)
  end

  def set_current_legislature
    @current_legislature = Legislature.get_current_legislature_by_deputy(@deputy.id)
  end

  def set_max_expense
    @max_expense = @deputy.invoices.order(net_value: :desc).first
  end

  def set_page
    @page = params[:page].present? ? params[:page] : 1
  end

  def set_util
    @util = Sync::CSVData::Util.new
  end

end
