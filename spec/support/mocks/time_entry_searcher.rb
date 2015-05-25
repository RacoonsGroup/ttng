class TimeEntrySearcherMock < Mock
  def find(_)
    TimeEntry.all
  end

  def find_by_form(_)
    TimeEntry.all
  end
end