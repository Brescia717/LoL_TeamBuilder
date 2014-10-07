class BuildsController < ApplicationController
  def index
    if params[:search]
      @builds = Build.search(params[:search]).order(:name).page params[:page]
    else
      @builds = Build.all
      # @builds = Build.order(:id).page params[:page]  ## This was default from Mytopia
    end
  end

  def show
    @build = Build.find(params[:id])
    # @user = User.find(params[:user_id])
    @review = Review.new
    @reviews = @build.reviews.with_score.includes(:votes)
    # @build_photo = BuildPhoto.new
    # @data = LoLAPI.new(@build)
  end

  def new
    @build = Build.new
  end

  def create
    @build = Build.new(build_params)
    @build.user = current_user
    if @build.save
      redirect_to builds_path ## This will be redirect_to @build
    else
      render 'new'
    end
  end

  def edit
    @build = Build.find(params[:id])
  end

  def update
    @build = Build.find(params[:id])

    if @build.update(build_params)
      flash[:success] = "You have successfully updated your build."
      redirect_to build_path(@build)
    else
      flash[:alert] = "Oops! Something went wrong. Please try again."
      render "show"
    end
  end

  def destroy
  end

  private
  def build_params
    params.require(:build).permit(:title, :champion, :about, :tips)
  end
end
