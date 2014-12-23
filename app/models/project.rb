class Project < ActiveRecord::Base
  belongs_to :customer

  validates :name, :customer_id, :rate, presence: true

  delegate :name, to: :customer, prefix: true

  has_many :project_users
  has_many :users, through: :project_users
  has_many :project_infos

  has_many :tasks

  has_many :bugs, ->{ bug }, class: Task
  has_many :features, ->{ feature }, class: Task
  has_many :chores, ->{ chore }, class: Task

  def real_time
    tasks.to_a.inject(0) do |sum, task|
      sum + task.real_time
    end
  end

  def bug_time
    bugs.to_a.inject(0) do |sum, task|
      sum + task.real_time
    end
  end

  def task_time
    features.to_a.inject(0) do |sum, task|
      sum + task.real_time
    end
  end

  def chore_time
    chores.to_a.inject(0) do |sum, task|
      sum + task.real_time
    end
  end

  def rate
    Money.new rate_kopeks, 'RUB'
  end

  def rate=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :rate_kopeks, value.cents
  end
end
