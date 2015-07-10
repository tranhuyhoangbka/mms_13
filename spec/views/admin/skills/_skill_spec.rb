require "rails_helper"

RSpec.describe "admin/skills/skill", type: :view do
  let(:skill){create :skill}

  it "display skill partial" do
    render "skill", skill: skill
    expect(rendered).to match skill.name
  end
end