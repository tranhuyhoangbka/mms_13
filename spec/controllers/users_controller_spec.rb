require "rails_helper"

describe Admin::UsersController do
  login_admin

  let(:team){create :team, name: "sun flower"}
  let(:position){create :position, name: "Developer"}
  let(:user1){create :user, email: "user1@gmail.com", name: "user1",
                            team: team, position: position}
  let(:user2){create :user, email: "user2@gmail.com"}

  describe "GET #index" do
    context "with params[:q]" do
      it "populates an array users match team name" do
        get :index, q: "sun"
        expect(assigns :users).to match_array [user1]
      end

      it "render index template" do
        get :index, q: "sun" do
          expect(response).to render_template :index
        end
      end
    end

    context "without params[:q]" do
      it "populates an array of all users" do
        get :index
        expect(assigns :users).to match_array [user1, user2]
      end

      it "render index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do
    context "format html" do
      it "assign requested user to @user" do
        get :show, id: user1
        expect(assigns :user).to eq user1
      end
    end

    context "format csv" do            
      it "return content of csv file" do
        get :show, id: user1, format: :csv
        expect(response.body).to match "user1,user1@gmail.com,1992-08-02,Developer"
      end
    end
  end

  describe "GET #new" do
    it "assign a new user to @user" do
      get :new
      expect(assigns :user).to be_a_new User
    end

    it "render new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assign requested user to @user" do
      get :show, id: user1
      expect(assigns :user).to eq user1
    end

    it "render new template" do
      get :show, id: user1
      expect(response).to render_template :show
    end
  end

  describe "POST #create" do
    context "with valid attributes" do          
      it "save new user to database" do
        expect{post :create, user: attributes_for(:user)}.
                                   to change(User, :count).by 1
      end

      it "redirect to admin::users#show" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to admin_user_path assigns :user
      end
    end

    context "with invalid attributes" do
      it "does not save user to database" do
        expect{post :create, user: attributes_for(:invalid_user)}.
                                   not_to change User, :count
      end

      it "re-render new template" do
        post :create, user: attributes_for(:invalid_user)
        expect(response).to render_template :new
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "locates requested user to @user" do
        patch :update, id: user1, user: attributes_for(:user)
        expect(assigns :user).to eq user1
      end

      it "update @contact's attributes" do
        patch :update, id: user1, user: attributes_for(:user, name: "Jack Chang")
        user1.reload
        expect(user1.name).to eq "Jack Chang"
      end

      it "rediect to admin::users#show" do
        patch :update, id: user1, user: attributes_for(:user)
        expect(response).to redirect_to admin_user_path assigns :user
      end
    end

    context "with invalid attributes" do
      it "does not update attributes @user" do
        patch :update, id: user1, user: attributes_for(:invalid_user)
        user1.reload
        expect(user1.name).to eq "user1"
      end

      it "re-render edit template" do
        patch :update, id: user1, user: attributes_for(:invalid_user)
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "delete user form database" do
      user1
      expect{delete :destroy, id: user1}.to change(User, :count).by -1
    end

    it "rediect to admin::users#index" do
      delete :destroy, id: user1
      expect(response).to redirect_to admin_users_path
    end
  end
end