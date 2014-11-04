class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  has_many :time_entries, dependent: :destroy

  enum status: {
      finished: 0,
      in_progress: 1
  }

  enum task_type: {
      feature: 0,
      bug: 1,
      chore: 2
  }

  delegate :name, to: :project, prefix: true

  validates :user_id, :project, :project_id, :name, :status, :task_type, :date, presence: true

  def real_time
    time_entries.to_a.inject(0) do |sum, entry|
      sum + entry.duration
    end
  end
end
