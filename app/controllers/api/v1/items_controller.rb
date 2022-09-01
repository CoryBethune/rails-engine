class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(Item.all)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.one_item(item)
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.one_item(item), status: 201
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)

  end
end
