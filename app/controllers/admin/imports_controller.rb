class Admin::ImportsController < ApplicationController
  def create
    begin
      params[:model].safe_constantize.import_csv params[:file]
      flash[:success] = t "csv.success"
    rescue
      flash[:warning] = t "csv.fail"
    ensure
      redirect_to :back
    end
  end
end
