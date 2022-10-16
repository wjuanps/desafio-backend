require 'sync/csv_data/synchronizer'
require 'sync/csv_data/util'
require 'csv'

class DeputiesController < ApplicationController
  before_action :set_page, only: %i[ show index ]
  before_action :set_util, only: %i[ show index ]

  # GET /deputies or /deputies.json
  def index
    @deputy_name = params[:deputy_name].present? ? params[:deputy_name] : ''
    @year = params[:year].present? ? params[:year] : 2021
    @deputies = Deputy.get_list_deputies(@deputy_name, @year).page(@page).per(6)
  end

  # GET /deputies/1 or /deputies/1.json
  def show
    @deputy = Deputy.find_by_id(params[:id])

    if @deputy.nil?
      redirect_to root_path, notice: "Deputado não encontrado"
    else
      @invoices = Invoice.get_invoices_by_deputy(@deputy.id).page(@page).per(10)
      @total_expenses = @util.convert_cents_to_real(@deputy.invoices.total_expenses)
      @current_legislature = Legislature.get_current_legislature_by_deputy(@deputy.id)
      @max_expense = @deputy.invoices.order(net_value: :desc).first
    end
  end

  # GET /deputies/new
  def new
    @deputy = Deputy.new
  end

  # POST /deputies or /deputies.json
  def create
    file = params[:deputy][:file]
    filename = File.expand_path(file)

    @synchronizer = Sync::CSV_DATA::Synchronizer.new
    @synchronizer.sync(filename)

    redirect_to root_path, notice: 'Deputados cadastrados com sucesso!!'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = params[:page].present? ? params[:page] : 1
  end

  def set_util
    @util = Sync::CSV_DATA::Util.new
  end
end
