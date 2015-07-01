require 'rails_helper'

describe ProjectsController do
  let!(:user) { FactoryGirl.create(:user, :developer)}
  let!(:project) { FactoryGirl.create(:project) }

  before do
    sign_in user
  end

  describe '#index' do
    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end