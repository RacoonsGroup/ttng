class CommentsController < AuthenticatedController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  inject :comment_manager

  def show
    @info = @comment.decrypted_info(params[:password])
  end

  def new

  end

  def create
    comment_manager.create(comment_params) do |comment, saved|
      if saved
        NotifMailer.comment_create(comment).deliver_now! if params[:comment][:notify] == '1'
        redirect_to project_path(@project)
      else
        @comment = comment
        render :new
      end
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

  def comment_params
    CommentPermitter.permit(params)
  end
end