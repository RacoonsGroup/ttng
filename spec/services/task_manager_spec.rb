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

  describe '#update' do
    let!(:task) { FactoryGirl.create(:task, user: user, name: 'TEST') }
    let!(:time_entry) { FactoryGirl.create(:time_entry, task: task, duration: 10) }

    it 'updates task' do
      manager.update(task, name: 'AnotherName')
      expect(task.reload.name).to eq('AnotherName')
    end

    it 'destroys time_entry' do
      expect{
        manager.update(task, name: 'AnotherName', time_entries: [])
      }.to change(TimeEntry, :count).by -1
    end

    it 'updates time_entry' do
      manager.update(task, name: 'AnotherName', time_entries: [id: time_entry.id, duration: 15])
      expect(time_entry.reload.duration).to eq(15)
    end
  end
end