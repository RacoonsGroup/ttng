require 'rails_helper'

describe Project do
  let!(:project) { FactoryGirl.create(:project) }

  describe '#rate=' do
    it 'returns Money' do
      project.update_attributes!(rate: 20)
      expect(project.rate).to eq(Money.new(2000, 'RUB'))
    end
  end

  describe '#search' do
    context 'when differ case' do
      let!(:first_project)  { FactoryGirl.create :project, name: 'First project' }
      let!(:second_project) { FactoryGirl.create :project, name: 'Second PROJECT' }

      let(:search_resonse) { Project.search('project') }
      it { expect(search_resonse.count).to eq(2) }
    end
  end
end
