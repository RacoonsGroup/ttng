require 'spec_helper'

describe ManagerStatisticsPresenter do
  let!(:developer) { FactoryGirl.create(:user, :developer)}
  let!(:developer2) { FactoryGirl.create(:user, :developer)}
  let!(:task_feature) { FactoryGirl.create(:task, user: developer, task_type: 0) }
  let!(:task_bug) { FactoryGirl.create(:task, user: developer, task_type: 1) }
  let!(:task_chore) { FactoryGirl.create(:task, user: developer2, task_type: 2) }
  let!(:time_entry1) { FactoryGirl.create(:time_entry, task: task_feature, duration: 14) }
  let!(:time_entry2) { FactoryGirl.create(:time_entry, task: task_bug, duration: 15) }
  let!(:time_entry3) { FactoryGirl.create(:time_entry, task: task_chore, duration: 1) }

  subject { ManagerStatisticsPresenter.new }

  context 'when current date 05.02.2015' do
    before do
      Timecop.freeze(Time.local('2015', '02', '05'))
    end

    describe '#iteration' do
      it 'returns dates of beginning and ending iteration' do
        expect(subject.iteration).to eq('01.02 - 15.02')
      end
    end

    describe '#total_hours' do
      it 'returns sum all hours in this iteration for developers' do
        expect(subject.total_hours).to eq(160)
      end
    end

    describe '#hours' do
      it 'return all hours which must be work' do
        expect(subject.hours).to eq("160 (#{160})")
      end
    end

    describe '#spent_hours' do
      it 'return spent hours' do
        spent_hours = time_entry1.duration + time_entry2.duration + time_entry3.duration
        expect(subject.spent_hours).to eq(spent_hours)
      end
    end

    describe '#finished' do
      it 'return percentage for spent hours' do
        expect(subject.finished).to eq("30 (19%)")
      end
    end
  end
end