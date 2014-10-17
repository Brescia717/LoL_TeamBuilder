class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:upvote, :downvote]

  def index
  end

  def show
    @user = User.find(params[:id])
    @likes = @user.get_likes.size
    @dislikes = @user.get_dislikes.size
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      # flash[:success] = "You have successfully updated your profile."
      redirect_to user_path(@user)
    else
      # flash[:alert] = "You need to submit a photo."
      render 'show'
    end
  end

  def upvote
    @user = User.find(params[:id])
    @user.vote_by voter: current_user, vote: 'like'
    redirect_to @user
  end

  def downvote
    @user = User.find(params[:id])
    @user.vote_by voter: current_user, vote: 'bad'
    redirect_to @user
  end

  private
  def user_params
    return { email: nil } unless params[:user]
    params.require(:user).permit(:email)
  end
end
