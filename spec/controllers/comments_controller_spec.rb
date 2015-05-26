require 'rails_helper'

describe CommentsController do
  let!(:admin) { FactoryGirl.create(:user, :chief) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:comment) { FactoryGirl.create(:comment, project: project) }


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
        post :create, project_id: project, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(comment)
      end

      it 're-renders new template' do
        post :create, project_id: project, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, project_id: project, id: comment
      expect(response).to render_template(:edit)
    end
  end

  describe 'put #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project path' do
        put :update, project_id: project, id: comment, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to redirect_to(project_path(project))
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(comment)
      end

      it 're-renders edit template' do
        put :update, project_id: project, id: comment, comment: FactoryGirl.attributes_for(:comment)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'get #SHOW' do
    it 'renders show template' do
      get :show, project_id: project, id: comment
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to project_path' do
      delete :destroy, project_id: project, id: comment
      expect(response).to redirect_to(project_path(project))
    end
  end
end