class ProjectUser < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates :project, :user, presence: true
  validates :user, user_position: true
end
