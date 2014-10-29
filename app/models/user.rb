class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum position: {
      admin: 0,
      programmer: 1,
      manager: 2
  }

  self.per_page = 10

  validates :first_name, :last_name, :birth_date, :email, :position, :hire_date, presence: true

  def full_name
    "#{last_name} #{first_name}"
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
end
