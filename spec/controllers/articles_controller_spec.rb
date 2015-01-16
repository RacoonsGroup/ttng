require 'rails_helper'

describe ArticlesController do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:another_user) { FactoryGirl.create(:user, :developer) }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    before do
      sign_in another_user
    end

    it 'renders index template' do
      get :index
      expect(:response).to render_template(:index)
    end

    it 'assigns @articles' do
      get :index
      expect(assigns(:articles)).not_to be_nil
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

      it 'redirects to articles index' do
        post :create, article: FactoryGirl.attributes_for(:article)
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(article)
      end

      it 'redirects to articles index' do
        post :create, article: FactoryGirl.attributes_for(:article, :invalid_article)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    it 'renders edit template' do
      get :edit, id: article
      expect(response).to render_template(:edit)
    end
  end

  describe 'put #update' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to articles index' do
        put :update, id: article, article: FactoryGirl.attributes_for(:article)
        expect(response).to redirect_to(articles_path)
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(false)
        ManagerMock.any_instance.stubs(:item).returns(article)
      end

      it 'redirects to articles index' do
        put :update, id: article, article: FactoryGirl.attributes_for(:article)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'POST #read' do
    it 'redirects to articles index' do
      post :read, id: article
      expect(response).to redirect_to(articles_path)
    end
  end

  describe 'POST #unread' do
    it 'redirects to articles index' do
      post :unread, id: article
      expect(response).to redirect_to(articles_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to articles index' do
      delete :destroy, id: article
      expect(response).to redirect_to(articles_path)
    end
  end
end