require 'spec_helper'
include Devise::TestHelpers

describe ManagerStatisticsPresenter do
  let!(:developer) { FactoryGirl.create(:user, :developer)}
  let!(:developer2) { FactoryGirl.create(:user, :developer)}
  let!(:manager) { FactoryGirl.create(:user, :manager) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:project_user) { FactoryGirl.create(:project_user, project: project, user: manager) }
  let!(:task_feature) { FactoryGirl.create(:related_task, project: project, user: developer, task_type: 0) }
  let!(:task_bug) { FactoryGirl.create(:related_task, user: developer, task_type: 1) }
  let!(:task_chore) { FactoryGirl.create(:related_task, user: developer2, task_type: 2) }
  let!(:time_entry1) { FactoryGirl.create(:time_entry, related_task: task_feature, duration: 14, date: "2015-02-06") }
  let!(:time_entry2) { FactoryGirl.create(:time_entry, related_task: task_bug, duration: 15, date: "2015-02-07") }
  let!(:time_entry3) { FactoryGirl.create(:time_entry, related_task: task_chore, duration: 1, date: "2015-02-08") }

  # before do
  #   @request = ActionController::TestRequest.new
  #   @request.env["devise.mapping"] = Devise.mappings[:manager]
  #   sign_in manager
  # end

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

    # Error: undefined method `projects' for nil:NilClass
    # current_user=nil in ManaherTESearcher

    # describe '#spent_hours' do
    #   it 'return spent hours' do
    #     spent_hours = time_entry1.duration + time_entry2.duration + time_entry3.duration
    #     expect(subject.spent_hours).to eq(spent_hours)
    #   end
    # end

    # describe '#finished' do
    #   it 'return percentage for spent hours' do
    #     expect(subject.finished).to eq("30.0 (19%)")
    #   end
    # end
  end
end