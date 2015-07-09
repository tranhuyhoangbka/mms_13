require "rails_helper"

describe Admin::ProjectsController do
  login_admin
  subject{response}

  describe "GET #index" do
    it "populates an array of project" do
      project = create :project
      get :index
      expect(assigns(:projects)).to eq [project]
    end
    it "renders the #index view" do
      get :index
      is_expected.to render_template :index
    end
  end
  describe "GET #show" do
    it "assigns the requested project to @project" do
      project = create :project
      get :show, id: project
      expect(assigns :project).to eq project
    end
    it "renders the #show view" do
      get :show, id: (create :project)
      is_expected.to render_template :show
    end
  end
  describe "POST create" do
    context "creates with valid attributes" do
      it "creates a new project" do
        expect{
          post :create, project: attributes_for(:project)
        }.to change(Project, :count).by 1
      end
      it "redirects to the new project" do
        post :create, project: attributes_for(:project)
        is_expected.to redirect_to assigns Project.last
      end
    end
    context "creates with invalid attributes" do
      it "does not save the new project" do
        expect{
          post :create, project: attributes_for(:invalid_project)
        }.to_not change(Project, :count)
      end
      it "re-renders the create view" do
        post :create, project: attributes_for(:invalid_project)
        is_expected.to render_template :new
      end
    end
  end
  describe "PATCH update" do
    let(:project) {create :project, name: Settings.test.project_sample_1}

    context "inserts valid attributes" do
      it "located the requested project" do
        patch :update, id: project, project: attributes_for(:project)
        expect(assigns :project).to eq project
      end
      it "changes project's attributes" do
        patch :update, id: project, project: attributes_for(:project,
                                    name: Settings.test.project_sample_2)
        project.reload
        expect(project.name).to eq Settings.test.project_sample_2
      end
      it "redirects to the updated project" do
        patch :update, id: project, project: attributes_for(:project)
        is_expected.to redirect_to assigns project
      end
    end
    context "inserts invalid attributes" do
      it "located the requested project" do
        patch :update, id: project, 
                       project: attributes_for(:invalid_project)
        expect(assigns :project).to eq project
      end
      it "does not change project's attributes" do
        patch :update, id: project, 
                       project: attributes_for(:invalid_project)
        project.reload
        expect(project.name).to eq Settings.test.project_sample_1
      end
      it "re-renders the edit view" do
        patch :update, id: project, 
                       project: attributes_for(:invalid_project)
        is_expected.to render_template :edit
      end
    end
  end
  describe "DELETE destroy" do
    let(:project) {create :project}

    it "deletes project" do
      project
      expect{
        delete :destroy, id: project
        }.to change(Project, :count).by -1
    end

    it "redirects to index view" do
      delete :destroy, id: project
      is_expected.to redirect_to admin_projects_path
    end
  end
end
