class CommonComment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, polymorphic: true
  has_many :attaches, as: :attacheable, dependent: :destroy
  accepts_nested_attributes_for :attaches, allow_destroy: true

  default_scope -> { order('created_at ASC') }

  belongs_to :user
end
