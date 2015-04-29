require 'spec_helper'

describe Admin::CommentManager do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:comment) { FactoryGirl.create(:comment, project: project) }

  let!(:manager) { Admin::CommentManager.new(project) }

  describe '#create' do
    context 'without encryption' do
      it 'creates Comment' do
        expect{
          manager.create(FactoryGirl.attributes_for(:comment))
        }.to change(Comment, :count).by 1
      end
    end

    context 'with encryption' do
      it 'creates Comment' do
        expect{
          manager.create(FactoryGirl.attributes_for(:comment, password: 'test'))
        }.to change(Comment, :count).by 1
      end
    end
  end

  describe '#update' do
    context 'without encryption' do
      it 'updates project info' do
        manager.update(comment ,FactoryGirl.attributes_for(:comment, title: 'new_title'))
        expect(comment.reload.title).to eq('new_title')
      end
    end

    context 'with encryption' do
      it 'updates project info' do
        manager.update(comment ,FactoryGirl.attributes_for(:comment, title: 'new_title', password: 'test'))
        expect(comment.reload.title).to eq('new_title')
      end
    end
  end
end