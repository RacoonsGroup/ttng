require 'rails_helper'

describe Task do
  let!(:task) { FactoryGirl.create(:task) }
  let!(:time_entry1) { FactoryGirl.create(:time_entry, task: task, duration: 14) }
  let!(:time_entry2) { FactoryGirl.create(:time_entry, task: task, duration: 15) }


  describe '#real_time' do
    it 'returns sum of entries duration' do
      expect(task.real_time).to eq(29)
    end
  end
end