require 'spec_helper'

describe ArticleManager do
  let!(:user) { FactoryGirl.create(:user, :developer) }
  let!(:project) { FactoryGirl.create(:project) }
  let!(:article) { FactoryGirl.create(:article) }

  let!(:manager) { ArticleManager.new.override_dependency(:current_user, user) }

  describe '#read!' do
    it 'marks article as readed' do
      expect{
        manager.read!(article)
      }.to change(UserArticle, :count).by 1
    end
  end

  describe '#unread!' do
    it 'marks article as unreaded' do
      manager.unread!(article)
    end
  end
end