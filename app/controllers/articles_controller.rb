class ArticlesController < AuthenticatedController
  inject :article_manager
  load_and_authorize_resource except: [:index, :create, :update]

  def index
    @articles = Article.includes(:user, :users).paginate(page: params[:page], per_page: 20)
  end

  def new
    authorize! :create, Article
  end

  def create
    authorize! :create, Article
    article_manager.create(article_params) do |article, saved|
      if saved
        redirect_to articles_path
      else
        @article = article
        render :new
      end
    end
  end

  def edit

  end

  def show

  end

  def update
    article = current_user.articles.find(params[:id])
    authorize! :update, article
    article_manager.update(article, article_params) do |article, saved|
      if saved
        redirect_to articles_path
      else
        @article = article
        render :edit
      end
    end
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

  private

  def article_params
    ArticlePermitter.permit(params)
  end
end