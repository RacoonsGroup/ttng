require 'rails_helper'

describe ProjectManager do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:customer) { FactoryGirl.create(:customer) }
  let!(:project) { FactoryGirl.create(:project, customer: customer) }
  let!(:project_user) { FactoryGirl.create(:project_user, project: project) }

  let!(:manager) { ProjectManager.new.override_dependency(:current_user, user) }

  describe '#create' do
    it 'creates project' do
      manager.create(FactoryGirl.attributes_for(:project).merge(customer_id: customer.id, users: [{ id: user.id }]))
    end
  end

  describe '#update' do
    it 'updates project' do
      manager.update(project, FactoryGirl.attributes_for(:project).merge(users: [{ id: user.id }]))
    end
  end
end
