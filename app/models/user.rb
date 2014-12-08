class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum position: {
      nobody: 0,
      admin: 1,
      developer: 2,
      manager: 3
  }

  self.per_page = 10

  has_many :project_users
  has_many :projects, through: :project_users

  has_many :tasks, dependent: :destroy
  has_many :time_entries, through: :tasks

  has_many :articles

  has_many :user_articles

  has_many :related_articles, class: Article, through: :user_articles

  validates :first_name, :last_name, :birth_date, :email, :position, :hire_date, presence: true

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

  def admin_or_manager?
    admin? || manager?
  end
end
