class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :attaches, dependent: :destroy
  accepts_nested_attributes_for :attaches, allow_destroy: true


  enum position: {
      nobody: 0,
      chief: 1,
      developer: 2,
      manager: 3,
      customer: 4,
      hr: 5,
      buh: 6,
      teamleader: 7,
      saler: 8,
      freelancer: 9
  }

  scope :developers, -> { where(position: [User.positions[:developer], User.positions[:teamleader], User.positions[:manager]]) }
  scope :chiefs, -> { where(position: User.positions[:chief]) }
  scope :nobodies, -> { where(position: User.positions[:nobody]) }
  scope :managers, -> { where(position: User.positions[:manager]) }
  scope :customers, -> { where(position: User.positions[:customer]) }
  scope :hrs, -> { where(position: User.positions[:hr]) }
  scope :buhs, -> { where(position: User.positions[:buh]) }
  scope :teamleaders, -> { where(position: User.positions[:teamleader]) }
  scope :salers, -> { where(position: User.positions[:sale]) }
  scope :freelancers, -> { where(position: User.positions[:freelancer]) }
  scope :available, -> { where('position != ?', User.positions[:nobody]) }

  self.per_page = 10

  has_many :project_users
  has_many :projects, through: :project_users

  has_many :related_tasks, dependent: :destroy
  has_many :time_entries, through: :related_tasks

  has_many :articles

  has_many :user_articles

  has_many :related_articles, class: Article, through: :user_articles, source: :article
  has_many :comments

  validates :first_name, :last_name, :birth_date, :email, :position, :hire_date, presence: true


  def self.groupe(form)
    if form == Comment.forms[:developer]
      positions = [:chief, :developer, :teamleader]
    elsif form == Comment.forms[:commercial]
      positions = [:chief, :manager]
    else
      positions = [:chief, :developer, :manager, :teamleader]
    end
    where position: User.positions.values_at(*positions)
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  def full_name_with_position
    "#{full_name} (#{position_i18n})"
  end

  def salary
    Money.new salary_kopeks, 'RUB'
  end

  def salary=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :salary_kopeks, value.cents
  end

  def official_salary
    Money.new official_salary_kopeks, 'RUB'
  end

  def official_salary=(value)
    value = Money.new(value.to_i * 100, 'RUB')
    write_attribute :official_salary_kopeks, value.cents
  end

  def avatar
    Gravatar.new(email).image_url
  end
end
