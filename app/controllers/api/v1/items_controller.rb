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

  def destroy
    render json: Item.delete(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.one_item(item)
    else
      render status: 404
    end

    # if item = Item.update(params[:id], item_params)
    #   render json: ItemSerializer.one_item(item)
    # else
    #   render status: 404
    # end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
