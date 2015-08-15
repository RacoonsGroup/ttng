class Attach < ActiveRecord::Base
  belongs_to :comment
  belongs_to :attacheable, polymorphic: true
  belongs_to :user
  validates :attachment, presence: true

  mount_uploader :attachment, AttachUploader
end
