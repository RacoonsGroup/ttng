class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  enum status: {
      in_progress: 0,
      finished: 1,
  }

  enum type: {
      feature: 0,
      bug: 1,
      chore: 2
  }


  validates :user_id, :project_id, :name, :status, :type, presence: true
end
