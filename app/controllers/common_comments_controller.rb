class CommonCommentsController < AuthenticatedController

  def show
    @common_comment = CommonComment.find(params[:id])
  end

  def new
    @common_comment = CommonComment.new
  end

  def create
    @common_comment = CommonComment.new(common_comment_params)
    if @common_comment.save
      flash[:notice] = "Comment created"
      redirect_to :back
    else
      render :new
    end
  end

  def edit

  end

  def update
    comment_manager.update(@comment, comment_params) do |comment, saved|
      if saved
        NotifMailer.comment_create(comment).deliver_now! if params[:comment][:notify] == '1'
        redirect_to project_path(@project)
      else
        @comment = comment
        render :edit
      end
    end
  end

  def destroy
    comment_manager.destroy(@comment)
    redirect_to project_path(@project)
  end

  private

  def common_comment_params
    CommonCommentPermitter.permit(params)
  end
end
