require 'spec_helper'

describe DeveloperTaskSearcher do
  let!(:user) { FactoryGirl.create :user, :developer }
  let!(:searcher) { DeveloperTaskSearcher.new.override_dependency(:current_user, user) }

  describe '#find' do
    context 'with searching by name' do
      let!(:related_task) { FactoryGirl.create(:related_task, user: user, name: 'test') }

      it 'finds tasks' do
        expect(searcher.find(name: 'test')).to match_array([related_task])
      end
    end

    context 'with searching by project_id' do
      let!(:project) { FactoryGirl.create(:project) }
      let!(:related_task) { FactoryGirl.create(:related_task, user: user, name: 'test', project: project) }

      it 'finds tasks' do
        expect(searcher.find(project_id: project.id)).to match_array([related_task])
      end
    end
  end

  describe '#find_by_form' do
    let!(:project) { FactoryGirl.create(:project) }
    let!(:related_task) { FactoryGirl.create(:related_task, user: user, project: project, date: Date.today) }


    context 'with project' do
      let!(:form) { RelatedTaskSearchForm.new(projects: [project.id.to_s], from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([related_task])
      end
    end

    context 'without project' do
      let!(:form) { RelatedTaskSearchForm.new(from: Date.today, to: Date.today, payable: 'false') }

      it 'finds tasks' do
        expect(searcher.find_by_form(form)).to match_array([related_task])
      end
    end
  end
end