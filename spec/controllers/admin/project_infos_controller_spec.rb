require 'rails_helper'

describe Admin::ProjectInfosController do
  let!(:admin) { FactoryGirl.create(:user, :admin) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:project_info) { FactoryGirl.create(:project_info, project: project) }


  before do
    sign_in admin
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new, project_id: project
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project page' do
        post :create, project_id: project, project_info: FactoryGirl.attributes_for(:project_info)
        expect(response).to redirect_to(admin_project_path(project))
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(project_info)
      end

      it 're-renders new template' do
        post :create, project_id: project, project_info: FactoryGirl.attributes_for(:project_info)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, project_id: project, id: project_info
      expect(response).to render_template(:edit)
    end
  end

  describe 'put #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project path' do
        put :update, project_id: project, id: project_info, project_info: FactoryGirl.attributes_for(:project_info)
        expect(response).to redirect_to(admin_project_path(project))
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(project_info)
      end

      it 're-renders edit template' do
        put :update, project_id: project, id: project_info, project_info: FactoryGirl.attributes_for(:project_info)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'get #SHOW' do
    it 'renders show template' do
      get :show, project_id: project, id: project_info
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to project_path' do
      delete :destroy, project_id: project, id: project_info
      expect(response).to redirect_to(admin_project_path(project))
    end
  end
end