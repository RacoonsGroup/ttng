require 'rails_helper'

describe CustomersController do
  let!(:customer) { FactoryGirl.create(:customer) }
  let!(:admin) { FactoryGirl.create(:user, :chief) }

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

      it 'redirects to customer index' do
        post :create, customer: FactoryGirl.attributes_for(:customer)
        expect(response).to redirect_to(customers_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(customer)
      end

      it 'renders new template' do
        post :create, customer: FactoryGirl.attributes_for(:customer, :invalid_customer)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #EDIT' do
    it 'renders edit template' do
      get :edit, id: customer
      expect(response).to render_template(:edit)
    end
  end



  describe 'PATCH #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to customer index' do
        patch :update, id: customer, customer: FactoryGirl.attributes_for(:customer)
        expect(response).to redirect_to(customers_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(customer)
      end

      it 'renders edit template' do
        patch :update, id: customer, customer: FactoryGirl.attributes_for(:customer)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to customer index' do
      delete :destroy, id: customer
      expect(response).to redirect_to(customers_path)
    end
  end
end