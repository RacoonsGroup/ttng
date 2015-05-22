class RelatedTaskSearcherMock < Mock
  def find(_)
    RelatedTask.all
  end

  def find_by_form(_)
    RelatedTask.all
  end
end