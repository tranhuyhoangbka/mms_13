require "rails_helper"

RSpec.describe "admin/positions/index.html.erb", type: :view do
  login_admin
  subject{rendered}
  
  before do
    15.times {create :position}
    @positions = Position.paginate page: params[:page], 
                                   per_page: Settings.general.per_page
    @position = build :position                                  
    render
  end

  it "request to positions controller" do
    expect(controller.request.path_parameters[:controller]).to eq "admin/positions"
  end

  it "request to index action" do
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "should include import csv form" do    
    is_expected.to have_selector "input.field-import-file"
  end

  it "should include link download csv file" do
    is_expected.to include "Download", "CSV"
  end

  it "should include form create position" do
    is_expected.to have_selector("#new_position") do |form|
      subject{form}

      is_expected.to have_field "#position_name"
      is_expected.to have_field "#position_abbreviation"
      is_expected.to have_button "Create Position"
    end
  end

  it "should list all positions" do
    @positions.each {|position| is_expected.to include position.name,
                                                       position.abbreviation}
  end

  it "should include pagination" do
    is_expected.to have_selector "div.pagination"
  end
end