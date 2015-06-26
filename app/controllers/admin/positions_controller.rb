class Admin::PositionsController < ApplicationController
  before_action :set_position, only: [:edit, :update, :destroy]
  
  def index
    @positions = Position.paginate page: params[:page], 
                                   per_page: Settings.general.per_page
    @position = Position.new
    respond_to do |format|    
      format.html
      format.csv {send_data @positions.to_csv}
    end
  end

  def create
    @position = Position.new position_params
    if @position.save
      flash[:success] = t "position.create_success"      
    else
      flash[:danger] = t "position.create_not_success"      
    end
    redirect_to admin_positions_url
  end

  def edit
  end

  def update
    if @position.update_attributes position_params
      flash[:success] = t "position.update_success"
      redirect_to admin_positions_url
    else
      render "edit"
    end
  end
  
  def destroy
    @position.destroy
    redirect_to admin_positions_url
  end

  private
  def position_params
    params.require(:position).permit :name, :abbreviation
  end

  def set_position
    @position = Position.find params[:id]
  end
end
