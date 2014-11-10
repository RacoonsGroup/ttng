class StatisticsPresenter
  include ApplicationHelper

  def initialize(user)
    @user = user
    @task_searcher = TaskSearcher.new.override_dependency(:current_user, @user)
  end

  def iteration
    @iteration ||= "#{iteration_date(Date.today.iteration.beginning)} - #{iteration_date(Date.today.iteration.end)}"
  end

  def hours
    @hours ||= "#{Date.today.iteration.total_hours} (#{Date.today.iteration.business_hours})"
  end

  def finished
    tasks = @task_searcher.between(Date.today.iteration.beginning, Date.today.iteration.end)
    spent_hours = tasks.to_a.inject(0){ |s, t| s + t.real_time }
    percentage = spent_hours / hours.to_f * 100
    "#{hours} (#{percentage.round}%)"
  end
end