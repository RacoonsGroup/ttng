require 'rails_helper'

describe WelcomeController do
  describe 'GET #show' do
    it 'renders show template' do
      get :show
      expect(response).to render_template(:show)
    end
  end
end