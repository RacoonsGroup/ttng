require 'rails_helper'

describe Admin::DaysController do
  let!(:admin) { FactoryGirl.create(:user, :manager) }
  let!(:day) { FactoryGirl.create(:day) }

  before do
    sign_in admin
  end

  describe '#index' do
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

      it 'redirects to days index' do
        post :create, day: FactoryGirl.attributes_for(:day)
        expect(response).to redirect_to(admin_days_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(day)
      end

      it 'redirects to days index' do
        post :create, day: FactoryGirl.attributes_for(:day)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, id: day
      expect(response).to render_template(:edit)
    end
  end

  describe 'put #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to days index' do
        put :update, id: day, day: FactoryGirl.attributes_for(:day)
        expect(response).to redirect_to(admin_days_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(day)
      end

      it 'redirects to days index' do
        put :update, id: day, day: FactoryGirl.attributes_for(:day)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to days index' do
      delete :destroy, id: day
      expect(response).to redirect_to(admin_days_path)
    end
  end
end