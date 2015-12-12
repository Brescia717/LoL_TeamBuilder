class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @team = Team.find(params[:team_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.team_id = params[:team_id]
    if @comment.save
      flash[:success] = "You have successfully posted your comment."
      redirect_to team_path(@team)
    else
      redirect_to team_path(@team)
      flash[:alert] = "Comment cannot be blank."
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "You have successfully updated your comment."
      redirect_to team_path(@comment.team)
    else
      flash[:notice] = "Please correct changes."
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "You successfully deleted your comment."

    redirect_to team_path(@comment.team)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
