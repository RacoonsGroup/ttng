class ArticlePermitter < Permitter
  fields [:title, :description, :url, :content, :importance]
  namespace :article
end