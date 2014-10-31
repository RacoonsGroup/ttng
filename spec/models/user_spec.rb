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
end