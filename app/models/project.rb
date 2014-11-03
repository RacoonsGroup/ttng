class Project < ActiveRecord::Base
  belongs_to :customer

  validates :name, :customer_id, :rate, presence: true

  delegate :name, to: :customer, prefix: true

  has_many :project_users
  has_many :users, through: :project_users

  has_many :tasks

  def rate
    Money.new rate_kopeks, 'RUB'
  end

  def rate=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :rate_kopeks, value.cents
  end
end
