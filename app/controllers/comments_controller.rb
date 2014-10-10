class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @build = Build.find(params[:build_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user # these had _id and .id
    @comment.build_id = params[:build_id]
    if @comment.save
      # CommentConfirmation.notification(@comment, @comment.build.user).deliver
      flash[:success] = "You have successfully posted your comment."
      redirect_to build_path(@build)
    else
      render 'builds/show'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    # @build = Build.find(params[:id])
    # @comment.build_id = params[:build_id]

    if @comment.update(comment_params)
      flash[:notice] = "You have successfully updated your comment."
      redirect_to build_path(@comment.build)
    else
      flash[:notice] = "Please correct changes."
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "You successfully deleted your comment."

    redirect_to build_path(@comment.build)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
