require 'rails_helper'

describe ArticlesController do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:article) { FactoryGirl.create(:article, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(:response).to render_template(:index)
    end

    it 'assigns @articles' do
      get :index
      expect(assigns(:articles)).not_to be_nil
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