class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @likes = @team.get_likes.size
    @dislikes = @team.get_dislikes.size
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

  private
  def user_params
    return { email: nil } unless params[:user]
    params.require(:user).permit(:email)
  end
end
