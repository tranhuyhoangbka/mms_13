require "rails_helper"

RSpec.describe "admin/skills/index", type: :view do
  login_admin  
  subject{rendered}

  before do
    15.times {create :skill}
    @skills = Skill.paginate page: params[:page], per_page: Settings.general.per_page
    @skill = build :skill
    render
  end

  it "request to skills controller and index action" do
    expect(controller.request.path_parameters[:controller]).to eq "admin/skills"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "should contain all skills" do
    @skills.each {|skill| is_expected.to match skill.name}
  end

  it "should contain form create skill" do
    is_expected.to have_selector "#new_skill"
  end

  it "should contain link to download csv" do
    is_expected.to include "Download", "CSV"
  end
  
  it "should contain form to import csv" do
    is_expected.to have_selector ".field-import-file"
  end 
end