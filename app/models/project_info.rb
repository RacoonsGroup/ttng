class ProjectInfo < ActiveRecord::Base
  belongs_to :project

  attr_accessor :password

  validates :title, :info, presence: true

  def decrypted_info(key = nil)
    if encrypted
      info.decrypt(:symmetric, password: key).encode('ascii-8bit').force_encoding('utf-8')
    else
      info
    end
  end
end
