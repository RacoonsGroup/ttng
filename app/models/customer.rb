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

  def self.filter(state)
    state = state.to_sym
    if state == :not_working
      Customer.includes(:projects)
        .where('projects.customer_id is ? or projects.state = ?', nil, 5)
        .references(:projects)
    else
      Customer.includes(:projects).where.not(projects: { state: 5 })
    end
  end

  def state
    not_complited.any? ? :working : :not_working
  end

  def substate
    if not_complited.many?
      :regular
    elsif not_complited.any?
      :new
    elsif projects.any?
      :finished
    else
      :not_started
    end
  end

  private

  def not_complited
    projects.not_complited
  end
end
