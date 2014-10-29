require 'rails_helper'

describe Admin::UsersController, type: :controller do
  let!(:admin) { FactoryGirl.create(:user, :admin) }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renders assigns @users' do
      get :index
      expect(assigns(:users)).not_to be_empty
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to users_path' do
        patch :update, id: admin.id, user: FactoryGirl.attributes_for(:user, :admin)
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(admin)
      end

      it 're-renders edit template' do
        patch :update, id: admin.id, user: FactoryGirl.attributes_for(:user, :admin, :invalid, password: '', password_confirmation: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to users_path' do
      delete :destroy, id: admin.id
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
