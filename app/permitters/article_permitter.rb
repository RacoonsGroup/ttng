class ArticlePermitter < Permitter
  fields [:title, :description, :url, :content]
  namespace :article
end