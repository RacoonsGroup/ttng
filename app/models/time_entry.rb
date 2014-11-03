class TimeEntry < ActiveRecord::Base
  belongs_to :task
  has_one :user, through: :task

  validates :task, :duration, presence: true
end
