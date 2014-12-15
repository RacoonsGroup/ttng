require 'rails_helper'

describe Admin::ProjectsController do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:project_user) { FactoryGirl.create(:project_user, project: project) }

  before do
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
      get :show, id: project
      expect(response).to render_template(:show)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to project index' do
      delete :destroy, id: project
      expect(response).to redirect_to(admin_projects_path)
    end
  end
end