class ArticleManager < ResourceManager::Base
  inject :current_user

  model ->{ current_user.articles }

  def read!(article)
    current_user.articles.push(article)
  end

  def unread(id)
    current_user.user_articles.find_by(article_id: id).try(&:destroy)
  end
end