require 'rails_helper'

describe Api::RemoteTasksController do
  let!(:user) { FactoryGirl.create(:user, :developer) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'has success response' do
      get :index, project_id: user.projects.first
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    it 'has success response' do
      get :show, project_id: user.projects.first, id: 100500
      expect(response).to be_success
    end
  end
end