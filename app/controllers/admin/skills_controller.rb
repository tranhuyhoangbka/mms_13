class Admin::SkillsController < Admin::BaseAdminController
  def index
    @skills = @skills.paginate page: params[:page], per_page:
                                   Settings.general.per_page
    @skill = Skill.new
    respond_to do |format|
      format.html
      format.csv {send_data @skills.as_csv}
    end
  end  

  def create
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
end
