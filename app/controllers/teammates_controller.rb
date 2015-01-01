class TeammatesController < ApplicationController
  def index
  end

  def new
    @teammate = Teammate.new
  end

  def create
    @teammate = Teammate.new(teammate_params)
  end

  private

  def teammate_params
    params.require(:teammate).permit(:member)
  end
end
