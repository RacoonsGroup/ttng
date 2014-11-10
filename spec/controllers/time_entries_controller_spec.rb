require 'rails_helper'

describe TimeEntriesController do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:task) { FactoryGirl.create(:task, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project index' do
        post :create, task_id: task, time_entry: FactoryGirl.attributes_for(:time_entry)
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(task)
      end

      it 'returns 422' do
        post :create, task_id: task, time_entry: FactoryGirl.attributes_for(:task)
        expect(response.status).to eq(422)
      end
    end
  end
end