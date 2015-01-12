require 'rails_helper'

describe GoogleExporter do
  let!(:user) { FactoryGirl.create(:user, google_token: 'token') }
  let!(:project) { FactoryGirl.create(:project) }
  subject { GoogleExporter.new.override_dependency(:current_user, user) }

  describe '#upload_file' do
    it 'do something' do
      subject.upload_file(project: project, content: 'content')
    end
  end
end