require 'rails_helper'

describe Customer do
  describe '#state' do
    let(:customer) { FactoryGirl.create :customer }

    describe 'when working' do
      context 'and substate new' do
        let!(:projects) { FactoryGirl.create_list :project, 1, customer: customer }
        it { expect(customer.state).to eq(:working) }
        it { expect(customer.substate).to eq(:new) }
      end

      context 'and substate regular' do
        let!(:projects) { FactoryGirl.create_list :project, 2, customer: customer }
        it { expect(customer.state).to eq(:working) }
        it { expect(customer.substate).to eq(:regular) }
      end
    end

    describe 'when not working' do
      context 'and substate finished' do
        let!(:projects) { FactoryGirl.create_list :project, 2, :finished, customer: customer }
        it { expect(customer.state).to eq(:not_working) }
        it { expect(customer.substate).to eq(:finished) }
      end

      context 'and substate not started' do
        it { expect(customer.state).to eq(:not_working) }
        it { expect(customer.substate).to eq(:not_started) }
      end
    end
  end
end