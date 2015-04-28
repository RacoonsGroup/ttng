class Customer < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  validates :name, :subject, :type, :source, presence: true
end
