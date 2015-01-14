class PivotalApiMock
  STORY = TrackerApi::Resources::Story.new({
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
  })

  def stories(_)
    [STORY]
  end

  def story(_)
    STORY
  end
end