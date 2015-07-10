require "rails_helper"

RSpec.describe "admin/skills/_form", type: :view do  
  before {@skill = create :skill}

  it "display partial _form" do
    render "form", skill: @skill
    expect(rendered).to include "Name", "Update Skill"
  end
end 