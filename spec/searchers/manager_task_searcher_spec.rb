require 'spec_helper'

describe ManagerTaskSearcher do
  let!(:manager) { FactoryGirl.create :user, :manager }
  let!(:developer) { FactoryGirl.create :user, :developer }
  let!(:searcher) { TaskSearcher.new }

  describe '#find' do
    context 'with searching by name' do
      let!(:task) { FactoryGirl.create(:task, user: developer, name: 'test') }

      it 'finds tasks' do
        expect(searcher.find(name: 'test')).to match_array([task])
      end
    end

    context 'with searching by project_id' do
      let!(:project) { FactoryGirl.create(:project) }
      let!(:task) { FactoryGirl.create(:task, user: developer, name: 'test', project: project) }

      it 'finds tasks' do
        expect(searcher.find(project_id: project.id)).to match_array([task])
      end
    end
  end

  describe '#find_by_form' do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:task) { FactoryGirl.create(:task, user: developer, project: project, date: Date.today) }
    let!(:developer2) { FactoryGirl.create :user, :developer }
    let!(:task2) { FactoryGirl.create(:task, user: developer2, project: project, date: Date.today) }


    context 'with project' do
      let!(:form) { TaskSearchForm.new(projects: [project.id.to_s], from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([task, task2])
      end
    end

    context 'without project' do
      let!(:form) { TaskSearchForm.new(from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([task, task2])
      end
    end

    context 'with developer' do
      let!(:form) { TaskSearchForm.new(developers: [developer.id.to_s], from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks for developer' do
        expect(searcher.find_by_form(form)).to match_array([task])
      end
    end

    context 'without developer' do
      let!(:form) { TaskSearchForm.new(from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks for developer' do
        expect(searcher.find_by_form(form)).to match_array([task, task2])
      end
    end
  end
end