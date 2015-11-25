require 'rails_helper'

describe Project do
  let!(:project) { FactoryGirl.create(:project) }

  describe '#rate=' do
    it 'returns Money' do
      project.update_attributes!(rate: 20)
      expect(project.rate).to eq(Money.new(2000, 'RUB'))
    end
  end

  describe '#users' do
    describe 'when users position is nobody' do
      let(:user)         { FactoryGirl.create :user, :nobody }
      let(:project_user) { FactoryGirl.build :project_user, user: user }
      it { expect(project_user.invalid?).to eq(true) }
    end

    describe 'when user position is not nobody' do
      let(:users) do
        availables = User.positions.to_hash
        availables.delete('nobody')
        availables.map do |position, number|
           FactoryGirl.create(:user, position.to_sym)
        end
      end

      it 'should be pused' do
        users.each do |user|
          expect(FactoryGirl.build(:project_user, user: user).valid?).to eq(true)
          expect{ project.users << user }.to change{ project.users.count }
        end
      end
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
