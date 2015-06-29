class Admin::ImportsController < ApplicationController
  before_action :admin_user
  
  def create
    begin
      import_csv params[:model].safe_constantize, params[:file]
      flash[:success] = t "csv.success"
    rescue
      flash[:warning] = t "csv.fail"
    end
    redirect_to :back
  end

  private
  def import_csv model, file
    CSV.foreach file.path, headers: true, header_converters: :downcase do |row|
      record = model.find_by(name: row["name"]) || model.new
      record.attributes = row.to_hash
      record.save!
    end
  end
end
