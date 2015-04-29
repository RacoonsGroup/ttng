require 'rails_helper'

describe TimeEntriesController do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:related_task) { FactoryGirl.create(:related_task, user: user) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        ManagerMock.any_instance.stubs(:result).returns(true)
      end

      it 'redirects to project index' do
        post :create, related_task_id: related_task, time_entry: FactoryGirl.attributes_for(:time_entry)
        expect(response).to be_success
      end
    end

    context 'with invalid params' do
      before do
        ManagerMock.any_instance.stubs(:item).returns(related_task)
      end

      it 'returns 422' do
        post :create, related_task_id: related_task, time_entry: FactoryGirl.attributes_for(:related_task)
        expect(response.status).to eq(422)
      end
    end
  end
end