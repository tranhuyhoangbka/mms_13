require "rails_helper"

describe Project do
  let(:project) {build :project}

  describe "test validate" do
    it "has valid project" do
      expect(build :project).to be_valid
    end
    it "is invalid without a name" do
      expect(build(:project, name: nil)).not_to be_valid
    end
    it "is invalid without a abbreviation" do
      expect(build(:project, abbreviation: nil)).not_to be_valid
    end
    it "is invalid without a start date" do
      expect(build(:project, start_date: nil)).not_to be_valid
    end
    it "is invalid without a end date" do
      expect(build(:project, end_date: nil)).not_to be_valid
    end
  end
  describe "test associations" do
    context "test has_many" do
      it {expect(project).to have_many :project_users}
      it {expect(project).to have_many :users}
    end
    context "test belongs_to" do
      it {expect(project).to belong_to :team}
      it {expect(project).to belong_to :leader}
    end
  end
end
