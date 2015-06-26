class Admin::SkillsController < ApplicationController
  before_action :admin_user
  before_action :set_skill, only: [:edit, :update, :destroy]

  def index
    @skills = Skill.paginate page: params[:page], per_page: 
                                   Settings.general.per_page
    @skill = Skill.new
    respond_to do |format|
      format.html
      format.csv {send_data @skills.as_csv}
    end
  end  

  def create
    @skill = Skill.new skill_params
    if @skill.save
      flash[:success] = t "skill.create_success"
    else
      flash[:danger] = t "skill.create_fail"
    end
    redirect_to admin_skills_url
  end

  def edit
  end

  def update
    if @skill.update_attributes skill_params
      flash[:success] = t "skill.update_success"
    else
      flash[:danger] = t "skill.update_fail"
    end
    redirect_to admin_skills_url
  end

  def destroy
    @skill.destroy
    flash[:success] = t "skill.delete_success"
    redirect_to admin_skills_url
  end

  private
  def skill_params
    params.require(:skill).permit :name
  end

  def set_skill
    @skill = Skill.find params[:id]
  end
end
