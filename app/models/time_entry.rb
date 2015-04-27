class TimeEntry < ActiveRecord::Base
  belongs_to :related_task
  has_one :user, through: :related_task

  validates :related_task, :duration, :date, presence: true
end
