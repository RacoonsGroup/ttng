class Contact < ActiveRecord::Base
  belongs_to :customer

  scope :free, -> { where('customer_id is NULL') }

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
