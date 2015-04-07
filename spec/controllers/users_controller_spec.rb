require 'rails_helper'

describe UsersController do
  let!(:user) { FactoryGirl.create(:user, :developer) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'renders assigns @users' do
      get :index
      expect(assigns(:users)).to match_array([user])
    end

    context 'with nobody user' do
      let!(:user1) { FactoryGirl.create(:user, :nobody) }

      it 'no showing nobody user' do
        get :index
        expect(assigns(:users)).not_to match_array([user, user1])
      end
    end
  end
end
