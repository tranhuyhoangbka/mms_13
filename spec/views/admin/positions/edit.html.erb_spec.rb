require "rails_helper"

RSpec.describe "admin/positions/edit.html.erb", type: :view do
  login_admin
  subject{rendered}

  before do
    @position = create :position
    render
  end

  context "should have enough element dom" do
    it "should include page header" do
      is_expected.to match "Edit Position"
    end

    it "should include form" do
      is_expected.to have_selector("form.edit_position") do |form|
        subject{form}

        is_expected.to have_field "input#position_name"
        is_expected.to have_field "input#position_abbreviation"
        is_expected.to have_button "Update Position"
      end
    end
  end

  context "should have attributes values" do
    it "should have position name" do
      is_expected.to match @position.name
    end

    it "should have position abbreviation" do
      is_expected.to match @position.abbreviation
    end
  end
end