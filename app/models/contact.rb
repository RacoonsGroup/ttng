class Contact < ActiveRecord::Base
  belongs_to :customer
  validates :first_name, presence: true

  scope :free, -> { where('customer_id is NULL') }

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.search(search)
    if search
      where('first_name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
