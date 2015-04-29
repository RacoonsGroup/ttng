class Comment < ActiveRecord::Base
  belongs_to :project

  attr_accessor :password

  enum form: {
      general: 0,
      commercial: 1,
      developer: 2
  }

  scope :generals, -> { where('form = ?', Comment.forms[:general]) }
  scope :commercials, -> { where('form = ?', Comment.forms[:commercial]) }
  scope :developers, -> { where('form = ?', Comment.forms[:developer]) }


  validates :title, :info, presence: true

  def decrypted_info(key = nil)
    if encrypted
      info.decrypt(:symmetric, password: key).encode('ascii-8bit').force_encoding('utf-8')
    else
      info
    end
  end
end
