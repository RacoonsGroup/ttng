class Project < ActiveRecord::Base
  belongs_to :customer

  validates :name, :customer_id, :rate, presence: true
  validates_uniqueness_of :name, scope: :customer_id

  delegate :name, to: :customer, prefix: true

  has_many :project_users
  has_many :users, through: :project_users
  has_many :comments

  has_many :related_tasks, -> { includes(:time_entries) }, dependent: :destroy

  has_many :bugs, ->{ includes(:time_entries).bug }, class: RelatedTask
  has_many :features, ->{ includes(:time_entries).feature }, class: RelatedTask
  has_many :chores, ->{ includes(:time_entries).chore }, class: RelatedTask

  def rate
    Money.new rate_kopeks, 'RUB'
  end

  def rate=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :rate_kopeks, value.cents
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
