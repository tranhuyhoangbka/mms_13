require "rails_helper"

RSpec.describe "admin/skills/edit", type: :view do
  login_admin
  subject{rendered} 
  
  before do
    @skill = create :skill
    render
  end

  it "include page header" do
    is_expected.to match "Edit Skill"
  end

  it "include form to edit skill" do
    is_expected.to have_selector ".edit_skill"
  end
end