class ExamplesController < ApplicationController
  add_breadcrumb :index, :examples_path

  def index
  end

  def show
    @example = Example.find params[:id]
    add_breadcrumb @example.name, example_path(@example)
    # add_breadcrumb :show, example_path(@example)
  end
end
