class ItemsController < ApplicationController
  # GET /items for use in testing authentication
  def index
    @items = Item.all

    render json: @items
  end

end
