class Article < ActiveRecord::Base
  belongs_to :user

  has_many :user_articles
  has_many :users, through: :user_articles

  validates :title, :description, :importance, presence: true

  validate :url_or_content

  private

  def url_or_content
    if !url.present? && !content.present?
      errors.add(:base, 'URL or content must be specified')
    end
  end
end
