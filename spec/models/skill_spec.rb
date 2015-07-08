require "rails_helper"

describe Skill do
  before do
    @skill1 = build :skill
    @skill2 = create :skill, name: "Android"
  end

  describe "Test validate" do
    context "has attributes valid" do
      it "build a valid skill" do
        expect(@skill1).to be_valid
      end
    end

    context "test name attribute" do
      it "is invalid without the name" do
        @skill1.name = nil
        @skill1.valid?
        expect(@skill1.errors[:name]).to include "can't be blank"
      end
      it "is invalid when have duplicate name" do
        @skill1.name = "Android"
        @skill1.valid?
        expect(@skill1.errors[:name]).to include "has already been taken"
      end
      it "is invalid when happen case sensitive" do
        @skill1.name = "android"
        @skill1.valid?
        expect(@skill1.errors[:name]).to include "has already been taken"
      end
    end   
  end

  describe "Test associations" do
    it {expect(@skill1).to have_many :skill_users}
    it {expect(@skill1).to have_many(:users).through :skill_users}
  end

  describe "Test methods" do
    it "take id by skill name with #get_id method" do
      expect(Skill.get_id "Android").to eq 1
    end
  end

  describe "Test export CSV" do
    it "returns collect skills" do      
      expect(Skill.as_csv).to match "1,Android,..."
    end
  end
end