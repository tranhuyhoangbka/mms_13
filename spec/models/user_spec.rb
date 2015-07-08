require "rails_helper"

describe User do
  before do
    @jame = create :user, email: "jame@gmail.com"
    @user = build :user
    @user1 = create :user, team_id: 1
    @admin = create :admin
    @position = create :position, name: "developer"    
  end

  describe "test validate" do
    context "has attributes be valid" do
      it "build a valid user" do
        expect(@user).to be_valid
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
      it {expect(@user).to belong_to :position}
      it {expect(@user).to belong_to :team}
    end
  end

  describe "Test scope and class method" do
    context "test #no_team_users scope" do
      it "return no team users list" do
        expect(User.no_team_users).to match_array [@jame, @admin]
      end
    end

    context "test #normal scope" do
      it "return users not admin list" do
        expect(User.normal).to match_array [@jame, @user1]
      end
    end

    context "test #get_id class method" do
      it "return id of user match with a email" do
        expect(User.get_id "jame@gmail.com").to eq 1
      end
    end
  end

  describe "Test instance method" do
    context "test #is_admin? method" do
      it "confirm is admin user" do
        expect(@admin.is_admin?).to be true
      end

      it "confirm a user is not admin" do
        expect(@user1.is_admin?).to be false
      end
    end

    context "test #is_user? method" do
      it "confirm is normal user" do
        expect(@user1.is_user?).to be true
      end

      it "confirm a user is not normal user" do
        expect(@admin.is_user?).to be false
      end
    end
  end

  describe "Test export csv" do
    it "returns information of user" do
      user_for_csv = create :user, email: "example_csv@gmail.com", name: "Sumner",
                            birthday: "1992-08-02", position: @position
      expect(user_for_csv.to_csv).to match(
                          "Sumner,example_csv@gmail.com,1992-08-02,developer")
    end
  end
end