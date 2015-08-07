require 'rails_helper'

describe Customer do
  describe '.filter' do
    let!(:working_customers) { FactoryGirl.create_list :customer, 10 }
    let!(:not_working_customers) { FactoryGirl.create_list :customer, 10 }
    let!(:projects) do
      working_customers.map do |customer|
        FactoryGirl.create :project, customer: customer
      end
    end
    let!(:finished_project) do
      not_working_customers[0..5].map do |customer|
        FactoryGirl.create :project, :finished, customer: customer
      end
    end
    context 'working' do
      let(:working_filter) { Customer.filter(:working) }
      it { expect(working_filter).to include(*working_customers) }
      it { expect(working_filter.count).to eq(working_customers.count) }
    end

    context 'not working' do
      let(:not_working_filter) { Customer.filter(:not_working)}
      it { expect(not_working_filter).to include(*not_working_customers) }
      it { expect(not_working_filter.count).to eq(not_working_customers.count) }
    end
  end

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