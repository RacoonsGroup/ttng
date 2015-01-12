class Project < ActiveRecord::Base
  belongs_to :customer

  validates :name, :customer_id, :rate, presence: true

  delegate :name, to: :customer, prefix: true

  has_many :project_users
  has_many :users, through: :project_users
  has_many :project_infos

  has_many :tasks, -> { includes(:time_entries) }, dependent: :destroy

  has_many :bugs, ->{ includes(:time_entries).bug }, class: Task
  has_many :features, ->{ includes(:time_entries).feature }, class: Task
  has_many :chores, ->{ includes(:time_entries).chore }, class: Task

  def rate
    Money.new rate_kopeks, 'RUB'
  end

  def rate=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :rate_kopeks, value.cents
  end
end
