require 'rails_helper'

describe PivotalApi do
  let!(:user) { FactoryGirl.create(:user, :developer, pivotal_token: 'token') }
  let!(:project) { FactoryGirl.create(:project, pivotal_id: 671099, users: [user]) }
  let!(:api) { PivotalApi.new(project).override_dependency(:current_user, user) }

  let!(:projects_response) {
    {
        id: 671099,
        kind: "project",
        name: "TimeTrack",
        version: 352,
        iteration_length: 1,
        week_start_day: "Monday",
        point_scale: "0,1,2,3",
        point_scale_is_custom: false,
        bugs_and_chores_are_estimatable: false,
        automatic_planning: true,
        enable_tasks: true,
        time_zone: {
            kind: "time_zone",
            olson_name: "Europe/Moscow",
            offset: "+03:00"
        },
        velocity_averaged_over: 3,
        number_of_done_iterations_to_show: 12,
        has_google_domain: false,
        enable_incoming_emails: true,
        initial_velocity: 10,
        public: true,
        atom_enabled: false,
        start_time: "2012-10-21T20:00:00Z",
        created_at: "2012-10-20T17:41:32Z",
        updated_at: "2015-01-13T21:01:45Z",
        account_id: 261899,
        current_iteration_number: 117,
        enable_following: true
    }
  }

  let!(:story_response) {
    {
        kind: "story",
        id: 82388652,
        project_id: 671099,
        name: "Интеграция с пивоталом",
        description: "Test description",
        story_type: "feature",
        current_state: "started",
        estimate: 3,
        requested_by_id: 1039367,
        owned_by_id: 1039367,
        owner_ids: [
            1039367
        ],
        labels: [ ],
        created_at: "2014-11-10T13:41:24Z",
        updated_at: "2014-12-22T11:58:51Z",
        url: "https://www.pivotaltracker.com/story/show/82388652"
    }
  }

  before do
    stub_request(:get, 'https://www.pivotaltracker.com/services/v5/projects/671099').
        to_return(status: 200, body: projects_response.to_json)

    stub_request(:get, 'https://www.pivotaltracker.com/services/v5/projects/671099/stories/82388652').
        to_return(status: 200, body: story_response.to_json)

    stub_request(:get, 'https://www.pivotaltracker.com/services/v5/projects/671099/stories?filter=((state:started%20or%20state:finished)%20or%20(story_type:chore%20and%20state:accepted))%20').
        to_return(status: 200, body: [story_response].to_json)
  end

  describe '#project_scope' do
    it 'returns scope' do
      expect(api.project_scope).to be_a_kind_of(TrackerApi::Resources::Project)
    end
  end

  describe '#story' do
    it 'return story' do
      expect(api.story(82388652)).to be_a_kind_of(TrackerApi::Resources::Story)
    end
  end

  describe '#stories' do
    it 'return story' do
      expect(api.stories).to be_a_kind_of(Array)
    end
  end

end