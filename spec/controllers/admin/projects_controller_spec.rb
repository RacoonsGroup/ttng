require 'rails_helper'

describe ProjectsController do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:admin) { FactoryGirl.create(:user, :chief) }
  let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: admin) }
  let!(:related_task) { FactoryGirl.create(:related_task, project: project, date: Date.parse('01.01.2014')) }

  before do
    byebug
    sign_in admin
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project index' do
        post :create, project: FactoryGirl.attributes_for(:project)
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(project)
      end

      it 'returns 422' do
        post :create, project: FactoryGirl.attributes_for(:project)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #EDIT' do
    it 'renders edit template' do
      get :edit, id: project
      expect(response).to render_template(:edit)
    end
  end



  describe 'PATCH #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project index' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:project)
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(project)
      end

      it 'returns 422' do
        patch :update, id: project, project: FactoryGirl.attributes_for(:project)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET #show' do
    it 'renders show template' do
      get :show, id: project, from: '01.01.1969', to: '01.01.2020'
      expect(response).to render_template(:show)
    end

    context 'with XLS format' do
      it 'has success response' do
        get :show, id: project, format: 'xlsx'
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to project index' do
      delete :destroy, id: project
      expect(response).to redirect_to(projects_path)
    end
  end

  describe 'GET #export' do
    it 'redirects to /auth/google_oauth2' do
      get :export, id: project
      expect(response).to redirect_to('/auth/google_oauth2')
    end
  end

  describe 'GET #to_google_drive' do
    it 'redirects to project page' do
      get :to_google_drive, id: project
      expect(response).to redirect_to(admin_project_path(project))
    end
  end
end