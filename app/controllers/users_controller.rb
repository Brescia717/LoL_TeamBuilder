class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:upvote, :downvote]
  before_action :get_user, except: [:index]

  def index
  end

  def show
    @stat  = Stat.new
    @stats = @user.stat
    @bios  = @user.bios
    @bio   = Bio.new
    @user_teams = Team.all.where(:user_id => @user.id)
    @likes    = @user.get_likes.size
    @dislikes = @user.get_dislikes.size
    @percentage_likes=
    if @likes > 0
      sprintf('%.0f', ((@likes.to_f / (@likes.to_f + @dislikes.to_f)) * 100)).to_s + '%'
    elsif @likes == 0 && @dislikes == 0
      "No registered votes"
    elsif @likes == 0 && @dislikes > 0
      "Uh-oh, better change your behavior!"
    else
      "100%"
    end
  end

  def update

    if @user.update(user_params)
      flash[:success] = "You have successfully updated your profile."
      redirect_to user_path(@user)
    else
      render 'show'
    end
  end

  def upvote
    @user.vote_by voter: current_user, vote: 'like'
    redirect_to @user
  end

  def downvote
    @user.vote_by voter: current_user, vote: 'bad'
    redirect_to @user
  end


  private

  def user_params
    return { email: nil } unless params[:user]
    params.require(:user).permit(:email)
  end

  def get_user
    @user = User.find(params[:id])
  end

end
