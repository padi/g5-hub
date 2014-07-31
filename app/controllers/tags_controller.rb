class TagsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @tag = params[:id]
  end
end
