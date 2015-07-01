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

  state_machine :state, initial: :first_contact do
    state :first_contact,      value: 0
    state :rating,             value: 1
    state :negotiate,          value: 2
    state :contract_is_signed, value: 3
    state :developing,         value: 4
    state :done,               value: 5

    event :estimate do
      transition [:first_contact] => :rating
    end

    event :discuss do
      transition [:rating] => :negotiate
    end

    event :sign do
      transition [:negotiate] => :contract_is_signed
    end

    event :develop do
      transition [:contract_is_signed] => :developing
    end

    event :complite do
      transition [:developing] => :done
    end
  end
end
