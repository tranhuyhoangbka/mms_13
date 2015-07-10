require "rails_helper"
require "will_paginate/array"

describe "admin/projects/index.html.erb", type: :view do
  subject{rendered}
  login_admin
  before do
    50.times {create :project}
    @projects = Project.paginate page: params[:page],
                                 per_page: Settings.general.per_page
    assign(:q, Project.ransack(params[:q]))
    render
  end

  it "should valid controller" do
    expect(controller.request.path_parameters[:controller]).to eq "admin/projects"
  end
  it "should contain all projects" do
    @projects.each {|project| is_expected.to include project.name}
  end
  it "should contain import CSV function" do
    is_expected.to include I18n.t("csv.import")
  end
  it "should have create project function" do
    is_expected.to include I18n.t("project.project_create")
  end
  it "should have will_paginate" do
    is_expected.to have_selector("div.pagination")
  end
end