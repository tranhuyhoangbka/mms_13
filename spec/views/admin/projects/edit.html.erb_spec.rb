require "rails_helper"

describe "admin/projects/edit", type: :view do
  login_admin
  subject{rendered}

  before do
    @project = create :project
    render
  end

  context "should valid action and controller" do
    it "should valid controller" do
      expect(controller.request.path_parameters[:controller]).to eq "admin/projects"
    end
    it "should valid action" do
      expect(controller.request.path_parameters[:action]).to eq "edit"
    end
  end

  context "should have exist values" do
    it "should have exist name value" do
      is_expected.to include @project.name
    end
    it "should have exist abbreviation value" do
      is_expected.to include @project.abbreviation
    end
    it "should have exist start date value" do
      is_expected.to include @project.start_date.to_s
    end
    it "should have exist end date value" do
      is_expected.to include @project.end_date.to_s
    end
  end

  context "should have form" do
    it "should have edit form" do
      is_expected.to have_selector ".edit_project"
    end
    it "should have project abbreviation input" do
      is_expected.to have_field "project_abbreviation"
    end
    it "should have project start date input" do
      is_expected.to have_field "project_start_date"
    end
    it "should have project end date input" do
      is_expected.to have_field "project_end_date"
    end
    it "should have project leader select" do
      is_expected.to have_field "project_leader_id"
    end
    it "should have submit button" do
      is_expected.to have_button "Submit"
    end
  end
end
