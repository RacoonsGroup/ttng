require 'rails_helper'

describe User do
  let!(:user) { FactoryGirl.create(:user, salary_kopeks: 1000, official_salary_kopeks: 100) }

  describe '#salary' do
    it 'returns Money' do
      expect(user.salary).to eq(Money.new(1000, 'RUB'))
    end
  end

  describe '#official_salary' do
    it 'returns Money' do
      expect(user.official_salary).to eq(Money.new(100, 'RUB'))
    end
  end

  describe '#salary=' do
    it 'returns Money' do
      user.update_attributes!(salary: 20)
      expect(user.salary).to eq(Money.new(2000, 'RUB'))
    end
  end

  describe '#official_salary=' do
    it 'returns Money' do
      user.update_attributes!(official_salary: 20)
      expect(user.official_salary).to eq(Money.new(2000, 'RUB'))
    end
  end

  describe '.groupe' do
    let(:users) do
      positions = User.positions.keys.map(&:to_sym)
      positions.each do |position|
        FactoryGirl.create_list :user, 2, position
      end
      User.order(:created_at).limit(positions.count)
    end

    context 'when form is general' do
      let(:groupe) { users.groupe(Comment.forms[:general]) }
      let(:positions) { ['chief', 'developer', 'manager', 'teamleader'] }
      it { expect(groupe.map(&:position).uniq).to eq(positions) }
      it { expect(groupe.count).to eq(positions.size * 2) }
    end

    context 'when form is developer' do
      let(:groupe) { users.groupe(Comment.forms[:developer]) }
      let(:positions) { ['chief', 'developer', 'manager', 'teamleader'] }
      it { expect(groupe.map(&:position).uniq).to eq(positions) }
      it { expect(groupe.count).to eq(positions.size * 2) }
    end

    context 'when form is commercial' do
      let(:groupe) { users.groupe(Comment.forms[:commercial]) }
      let(:positions) { ['chief', 'manager', 'teamleader'] }
      it { expect(groupe.map(&:position).uniq).to eq(positions) }
      it { expect(groupe.count).to eq(positions.size * 2) }
    end
  end
end