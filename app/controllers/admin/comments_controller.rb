class Admin::CommentsController < Admin::AdminController
  load_and_authorize_resource :project
  load_and_authorize_resource through: :project

  inject :comment_manager

  def new

  end

  def create
    comment_manager.create(comment_params) do |comment, saved|
      if saved
        redirect_to admin_project_path(@project)
      else
        @comment = comment
        render :new
      end
    end
  end

  def show
    @info = @comment.decrypted_info(params[:password])
  end

  def edit

  end

  def update
    comment_manager.update(@comment, comment_params) do |comment, saved|
      if saved
        redirect_to admin_project_path(@project)
      else
        @comment = comment
        render :edit
      end
    end
  end

  def destroy
    comment_manager.destroy(@comment)
    redirect_to admin_project_path(@project)
  end

  private

  def comment_params
    CommentPermitter.permit(params)
  end
end