class Day < ActiveRecord::Base
  validates :date, :reason, presence: true
end
