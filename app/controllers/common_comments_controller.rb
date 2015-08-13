class CommonCommentsController < AuthenticatedController
  inject :common_comment_manager
  before_filter :find_common_comment, only: [:edit, :update, :destroy, :show]

  def edit
  end

  def show
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

  def common_comment_params
    CommonCommentPermitter.permit(params)
  end

  def find_common_comment
    @common_comment = CommonComment.find(params[:id])
  end
end
