require "rails_helper"

describe User do
  before do
    @jame = create :user, email: "jame@gmail.com"
    @user = build :user
  end

  describe "test validate" do
    context "has attributes be valid" do
      it "build a valid user" do
        expect(build :user).to be_valid
      end
    end

    context "test email" do
      it "is invalid without a email" do
        user = build :user, email: nil   
        user.valid? 
        expect(user.errors[:email]).to include "can't be blank"
      end

      it "is invalid when does not unique email" do
        user = build :user, email: "jame@gmail.com"
        user.valid?
        expect(user.errors[:email]).to include "has already been taken"
      end
    end
    
    context "test name" do
      it "is invalid without a name" do
        user = build :user, name: nil
        user.valid?
        expect(user.errors[:name]).to include "can't be blank"
      end
    end  
    
    context "test birthday" do
      it "is invalid without a birthday" do
        user = build :user, birthday: nil
        user.valid?
        expect(user.errors[:birthday]).to include "can't be blank"
      end
    end
    
    context "test password" do
      it "is invalid without password" do
        user = build :user, password: nil
        user.valid?
        expect(user.errors[:password]).to include "can't be blank"
      end      

      it "is invalid when password less than 8 letters" do
        user = build :user, password: "1234567", password_confirmation: "1234567"
        expect(user).not_to be_valid
      end

      it "is invalid when does not match password and password confirm" do
        user = build :user, password_confirmation: "123456780"
        user.valid?
        expect(user.errors[:password_confirmation]).to include "doesn't match Password"
      end
    end
  end
   
  describe "Test associations" do
    context "test has_many" do
      it {expect(@user).to have_many :skill_users}
      it {expect(@user).to have_many :project_users}
      it {expect(@user).to have_many(:skills).through :skill_users}
      it {expect(@user).to have_many(:projects).through :project_users}
    end
  end
end