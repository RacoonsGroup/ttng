require 'spec_helper'

describe TaskManager do
  let!(:user) { FactoryGirl.create(:user, :programmer) }
  let!(:project) { FactoryGirl.create(:project) }

  let!(:manager) { TaskManager.new.override_dependency(:current_user, user) }

  describe '#create' do
    it 'creates new task' do
      expect{
        manager.create(FactoryGirl.attributes_for(:task, project_id: project.id))
      }.to change(Task, :count).by 1
    end
  end
end