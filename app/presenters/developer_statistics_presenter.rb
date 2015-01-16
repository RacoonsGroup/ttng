class DeveloperStatisticsPresenter < StatisticsPresenter

  def initialize
    @task_searcher = DeveloperTaskSearcher.new
  end

end