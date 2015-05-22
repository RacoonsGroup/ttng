require 'rails_helper'

describe RelatedTask do
  let!(:related_task) { FactoryGirl.create(:related_task) }
  let!(:time_entry1) { FactoryGirl.create(:time_entry, related_task: related_task, duration: 14) }
  let!(:time_entry2) { FactoryGirl.create(:time_entry, related_task: related_task, duration: 15) }


  describe '#real_time' do
    it 'returns sum of entries duration' do
      expect(related_task.real_time).to eq(29)
    end
  end
end