class StatisticsPresenter
  include ApplicationHelper

  def initialize
    @task_searcher = TimeEntrySearcher.new
  end

  def iteration
    @iteration ||= "#{iteration_date(Date.today.iteration.beginning)} - #{iteration_date(Date.today.iteration.end)}"
  end

  def total_hours
    Date.today.iteration.total_hours
  end

  def elapsed_hours
    Date.today.iteration.elapsed_hours
  end

  def hours
    @hours ||= "#{elapsed_hours} (#{Date.today.iteration.business_hours})"
  end

  def spent_hours
    tasks = @task_searcher.between(Date.today.iteration.beginning, Date.today.iteration.end)
    tasks.to_a.inject(0){ |s, t| s + t.duration }
  end

  def finished
    percentage = spent_hours / hours.to_f * 100
    "#{spent_hours.round(2)} (#{percentage.round}%)"
  end

  def delay
    (elapsed_hours - spent_hours).round(2)
  end
end
