class Customer < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :contacts
  validates :name, :subject, :profile, :source, presence: true
end
