require 'rails_helper'

describe Project do
  let!(:project) { FactoryGirl.create(:project) }

  describe '#rate=' do
    it 'returns Money' do
      project.update_attributes!(rate: 20)
      expect(project.rate).to eq(Money.new(2000, 'RUB'))
    end
  end
end
