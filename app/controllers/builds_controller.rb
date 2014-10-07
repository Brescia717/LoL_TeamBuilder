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
    @review = Review.new
    @reviews = @build.reviews.with_score.includes(:votes)
    # @neighborhood_photo = BuildPhoto.new
    # @data = ZillowAPI.new(@build)
  end

  def new
    @build = Build.new
  end

  def create
    @build = Build.new(build_params)

    if @build.save
      redirect_to @build
    else
      render 'new'
    end
  end

  def update
    @build = Build.find(params[:id])


    if @build.update(build_params)
      # flash[:success] = "You have successfully updated the build picture."
      redirect_to build_path(@build)
    else
      render "show"
    end
  end

  private
  def build_params
    params.require(:build).permit(:champion, :about, :items, :item_desc,
                                  :masteries, :masteries_desc, :runes,
                                  :runes_desc, :tips)
  end
end
