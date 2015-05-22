class Attach < ActiveRecord::Base
  belongs_to :comment
  validates :title, :attachment, presence: true

  mount_uploader :attachment, AttachUploader
end
