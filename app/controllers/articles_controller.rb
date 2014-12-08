class ArticlesController < AuthenticatedController
  inject :article_manager
  load_and_authorize_resource except: [:index]

  def index
    @articles = Article.all.includes(:user, :users)
  end

  def read
    article_manager.read!(@article)
    redirect_to articles_path
  end

  def unread
    article_manager.unread!(params[:id])
    redirect_to articles_path
  end

  def destroy
    article_manager.destroy(@article)
    redirect_to articles_path
  end
end