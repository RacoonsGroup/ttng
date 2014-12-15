class ProjectInfo < ActiveRecord::Base
  belongs_to :project

  attr_accessor :password

  validates :title, :info, presence: true

  def decrypted_info(key = nil)
    if encrypted
      info.decrypt(:symmetric, password: key)
    else
      info
    end
  end
end
