class Customer < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :contacts
  acts_as_taggable_on :technologies
  validates :name, :subject, :source, presence: true
  
  enum subject: {
    indiv: 0,
    legal_ent: 1
  }

  enum profile: {
    start_up: 0,
    software_dev: 1,
    related: 2
  }
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
