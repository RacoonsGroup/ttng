class Attach < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  validates :title, presence: true

  mount_uploader :attachment, AttachUploader
end
