class StockKeepingUnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_parameters, only: [:import]

  def new
  end

  def import
    myfile = params[:file]
    @rowarray_disp = Denomination.process_csv myfile
    combinations = Denomination.process_data @rowarray_disp, params[:sku_denominations]
    #Processing jobs in background
    @job = PopulateDataJob.perform_later(combinations, current_user)
    redirect_and_flash 'Sucessfully placed in queue for processing!', :notice, root_path
  end

private

  def validate_parameters
    unless (params[:file].present? && params[:sku_denominations].present?)
      redirect_and_flash 'File/Sku Denomination missing!', :error, root_path
    end
  end
end
