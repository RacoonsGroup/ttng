class ManagerStatisticsPresenter < StatisticsPresenter

  def initialize
    @task_searcher = ManagerTESearcher.new
    @developers_count = (User.developers - User.managers).count
  end

  def total_hours
    Date.today.iteration.total_hours * @developers_count
  end

  def elapsed_hours
    Date.today.iteration.elapsed_hours * @developers_count
  end

  def hours
    @hours ||= "#{elapsed_hours} (#{Date.today.iteration.business_hours * @developers_count})"
  end

  def spent_hours
    tasks = @task_searcher.between(Date.today.iteration.beginning, Date.today.iteration.end)
    tasks.to_a.inject(0){ |s, t| s + t.duration }
  end

  def finished
    if hours.to_i == 0
      '0'
    else
      percentage = spent_hours / total_hours.to_f * 100
      percentage.nan? ? '0' : "#{spent_hours.round(2)} (#{percentage.round}%)"
    end
  end

  def delay
    (elapsed_hours - spent_hours).round(2)
  end
end
