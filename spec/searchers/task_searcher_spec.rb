require 'spec_helper'

describe TaskSearcher do
  let!(:user) { FactoryGirl.create :user, :programmer }
  let!(:searcher) { TaskSearcher.new.override_dependency(:current_user, user) }

  describe '#find' do
    context 'with searching by name' do
      let!(:task) { FactoryGirl.create(:task, user: user, name: 'test') }

      it 'finds tasks' do
        expect(searcher.find(name: 'test')).to match_array([task])
      end
    end

    context 'with searching by project_id' do
      let!(:project) { FactoryGirl.create(:project) }
      let!(:task) { FactoryGirl.create(:task, user: user, name: 'test', project: project) }

      it 'finds tasks' do
        expect(searcher.find(project_id: project.id)).to match_array([task])
      end
    end
  end

  describe '#find_by_form' do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:task) { FactoryGirl.create(:task, user: user, project: project, date: Date.today) }


    context 'with project' do
      let!(:form) { TaskSearchForm.new(projects: [project.id.to_s], from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([task])
      end
    end

    context 'without project' do
      let!(:form) { TaskSearchForm.new(projects: [''], from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([task])
      end
    end
  end
end