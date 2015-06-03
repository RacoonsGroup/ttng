class DeveloperStatisticsPresenter < StatisticsPresenter

  def initialize
    @task_searcher = DeveloperTESearcher.new
  end

end