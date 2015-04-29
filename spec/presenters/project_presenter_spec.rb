require 'rails_helper'

describe ProjectPresenter do
  let!(:user) { FactoryGirl.create(:user, :developer)}
  let!(:task_feature) { FactoryGirl.create(:related_task, user: user, project: user.projects.first, task_type: 0) }
  let!(:task_bug) { FactoryGirl.create(:related_task, user: user, project: user.projects.first, task_type: 1) }
  let!(:task_chore) { FactoryGirl.create(:related_task, user: user, project: user.projects.first, task_type: 2) }
  let!(:time_entry1) { FactoryGirl.create(:time_entry, related_task: task_feature, duration: 14) }
  let!(:time_entry2) { FactoryGirl.create(:time_entry, related_task: task_bug, duration: 15) }
  let!(:time_entry3) { FactoryGirl.create(:time_entry, related_task: task_chore, duration: 1) }

  subject { ProjectPresenter.new(user.projects.first) }

  describe '#real_time_by(user)' do
    it 'returns entries duration for specific user' do
      expect(subject.real_time_by(user)).to eq(30)
    end
  end

  describe '#bug_time_by(user)' do
    it 'returns duration for bug tasks' do
      expect(subject.bug_time_by(user)).to eq(15)
    end
  end

  describe '#feature_time_by(user)' do
    it 'returns duration for feature tasks' do
      expect(subject.feature_time_by(user)).to eq(14)
    end
  end

  describe '#chore_time_by(user)' do
    it 'returns duration for chore tasks' do
      expect(subject.chore_time_by(user)).to eq(1)
    end
  end

end