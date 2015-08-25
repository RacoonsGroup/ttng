class CategoriesController < AuthenticatedController
  include TheSortableTreeController::Rebuild
  load_and_authorize_resource
  inject :category_manager
  layout 'wiki'

  def edit
  end

  def new

  end

  def manage
    @categories = Category.nested_set.select('id, name, parent_id').all
  end

  def create
    category_manager.create(category_params) do |category, saved|
      if saved
        redirect_to wiki_path
      else
        @category = category
        render :new
      end
    end
  end

  def update
    common_comment_manager.update(@common_comment, common_comment_params) do |comment, saved|
      if saved
        redirect_to @common_comment.commentable
      else
        @common_comment = comment
        render :edit
      end
    end
  end

  def destroy
    common_comment_manager.destroy(@common_comment)
    redirect_to :back
  end

  private

  def category_params
    CategoryPermitter.permit(params)
  end

  def find_common_comment
    @common_comment = CommonComment.find(params[:id])
  end
end
