require 'spec_helper'

describe RelatedTaskManager do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:project) { FactoryGirl.create(:project) }

  let!(:manager) { RelatedTaskManager.new.override_dependency(:current_user, user) }

  describe '#create' do
    it 'creates new task' do
      expect{
        manager.create(FactoryGirl.attributes_for(:related_task, project_id: project.id))
      }.to change(RelatedTask, :count).by 1
    end
  end

  describe '#update' do
    let!(:related_task) { FactoryGirl.create(:related_task, user: user, name: 'TEST') }
    let!(:time_entry) { FactoryGirl.create(:time_entry, related_task: related_task, duration: 10) }

    it 'updates task' do
      manager.update(related_task, name: 'AnotherName')
      expect(related_task.reload.name).to eq('AnotherName')
    end

    it 'destroys time_entry' do
      expect{
        manager.update(related_task, name: 'AnotherName', time_entries: [])
      }.to change(TimeEntry, :count).by -1
    end

    it 'updates time_entry' do
      manager.update(related_task, name: 'AnotherName', time_entries: [id: time_entry.id, duration: 15])
      expect(time_entry.reload.duration).to eq(15)
    end
  end
end