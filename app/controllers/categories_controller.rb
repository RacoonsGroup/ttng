class CategoriesController < AuthenticatedController
  include TheSortableTreeController::Rebuild
  load_and_authorize_resource
  inject :category_manager
  layout 'wiki'

  def edit
  end

  def new
  end

  def show
    @categories = [@category, @category.nested_categories].flatten
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
    category_manager.update(@category, category_params) do |category, saved|
      if saved
        redirect_to wiki_path
      else
        @category = category
        render :edit
      end
    end
  end

  def destroy
    category_manager.destroy(@category)
    redirect_to :back
  end

  private

  def category_params
    CategoryPermitter.permit(params)
  end
end
