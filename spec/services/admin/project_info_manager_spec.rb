require 'spec_helper'

describe Admin::ProjectInfoManager do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:project_info) { FactoryGirl.create(:project_info, project: project) }

  let!(:manager) { Admin::ProjectInfoManager.new(project) }

  describe '#create' do
    context 'without encryption' do
      it 'creates ProjectInfo' do
        expect{
          manager.create(FactoryGirl.attributes_for(:project_info))
        }.to change(ProjectInfo, :count).by 1
      end
    end

    context 'with encryption' do
      it 'creates ProjectInfo' do
        expect{
          manager.create(FactoryGirl.attributes_for(:project_info, password: 'test'))
        }.to change(ProjectInfo, :count).by 1
      end
    end
  end

  describe '#update' do
    context 'without encryption' do
      it 'updates project info' do
        manager.update(project_info ,FactoryGirl.attributes_for(:project_info, title: 'new_title'))
        expect(project_info.reload.title).to eq('new_title')
      end
    end

    context 'with encryption' do
      it 'updates project info' do
        manager.update(project_info ,FactoryGirl.attributes_for(:project_info, title: 'new_title', password: 'test'))
        expect(project_info.reload.title).to eq('new_title')
      end
    end
  end
end