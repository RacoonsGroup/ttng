class Customer < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :contacts
  acts_as_taggable_on :technologies
  validates :name, :subject, :source, presence: true
  
  enum subject: {
    phizik: 0,
    yurik: 1
  }

  enum profile: {
    start_up: 0,
    software_dev: 1,
    related: 2
  }
end
