require 'spec_helper'

describe TimeEntryManager do
  let!(:related_task) { FactoryGirl.create(:related_task) }

  let!(:manager) { TimeEntryManager.new }

  describe '#create' do
    it 'create TimeEntry' do
      expect{
        manager.create(related_task, FactoryGirl.attributes_for(:time_entry))
      }.to change(TimeEntry, :count).by 1
    end
  end
end