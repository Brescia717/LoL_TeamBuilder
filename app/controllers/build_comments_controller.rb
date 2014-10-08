class BuildCommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @build = Build.find(params[:build_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.review_id = params[:review_id]
    if @comment.save
      CommentConfirmation.notification(@comment, @comment.review.user).deliver
      flash[:success] = "You have successfully posted your comment."
      redirect_to neighborhood_review_path(@review.neighborhood, @review)
    else
      render 'reviews/show'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "You have successfully updated your comment."
      redirect_to neighborhood_review_path(@comment.review.neighborhood, @comment.review)
    else
      flash[:notice] = "Please correct changes."
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "You successfully deleted your comment."

    redirect_to neighborhood_review_path(@comment.review.neighborhood, @comment.review)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
