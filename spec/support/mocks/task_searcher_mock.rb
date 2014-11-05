class TaskSearcherMock < Mock
  def find(_)
    Task.all
  end

  def find_by_form(_)
    Task.all
  end
end