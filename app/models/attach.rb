class Attach < ActiveRecord::Base
  belongs_to :comment
  validates :title, presence: true

  mount_uploader :attachment, AttachUploader
end
