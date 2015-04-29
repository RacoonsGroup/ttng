class Contact < ActiveRecord::Base
  belongs_to :customer

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
