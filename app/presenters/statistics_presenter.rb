class StatisticsPresenter
  include ApplicationHelper

  def initialize(user)
    @user = user
    @task_searcher = TaskSearcher.new.override_dependency(:current_user, @user)
  end

  def iteration
    @iteration ||= "#{iteration_date(Date.today.iteration.beginning)} - #{iteration_date(Date.today.iteration.end)}"
  end

  def total_hours
    Date.today.iteration.total_hours
  end

  def hours
    @hours ||= "#{total_hours} (#{Date.today.iteration.business_hours})"
  end

  def spent_hours
    tasks = @task_searcher.between(Date.today.iteration.beginning, Date.today.iteration.end)
    tasks.to_a.inject(0){ |s, t| s + t.real_time }
  end

  def finished
    percentage = spent_hours / hours.to_f * 100
    "#{spent_hours} (#{percentage.round}%)"
  end
end