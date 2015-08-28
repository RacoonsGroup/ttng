class WikiPage < ActiveRecord::Base
  acts_as_wiki_page

  belongs_to :category
end
