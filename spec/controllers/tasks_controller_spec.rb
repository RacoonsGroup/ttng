require 'rails_helper'

describe TasksController do

  let!(:task) { FactoryGirl.create(:task) }
  let!(:user) { FactoryGirl.create(:user, :programmer) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'without assigned tasks' do
      it 'assigns valid @tasks' do
        get :index
        expect(assigns(:tasks)).to be_empty
      end
    end

    context 'with assigned tasks' do
      let!(:task1) { FactoryGirl.create(:task, user: user) }

      it 'assigns valid @tasks' do
        get :index
        expect(assigns(:tasks)).to match_array([task1])
      end
    end
  end

end
