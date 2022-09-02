require 'rails_helper'

RSpec.describe 'Items API' do
  it "gets all of the items" do
    create_list(:item, 3)

    get "/api/v1/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(response).to be_successful

    expect(items.count).to eq(3)
    expect(items[0].count).to eq(3)
    expect(items[0][:attributes].count).to eq(4)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_an(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "gets one item" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    expect(response).to be_successful

    expect(item.count).to eq(3)
    expect(item[:attributes].count).to eq(4)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to be_an(String)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_an(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_an(Float)

    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it "creates one item" do
    id = create(:merchant).id
    item_params = {
      name: "fork",
      description: 'eat with this utensil.',
      unit_price: 0.99,
      merchant_id: id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    new_item = Item.last

    expect(response).to be_successful

    expect(new_item).to be_an(Item)
    expect(new_item.name).to eq('fork')
    expect(new_item.description).to eq('eat with this utensil.')
    expect(new_item.unit_price).to eq(0.99)
    expect(new_item.merchant_id).to eq(id)

  end

  it "deletes one item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "updates one item" do
    merchant_id = create(:merchant).id
    id = create(:item).id
    old_name = Item.last.name
    old_description = Item.last.description
    old_unit_price = Item.last.unit_price

    item_params = {
      name: "fork",
      description: 'eat with this utensil.',
      unit_price: 0.99
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    expect(Item.count).to eq(1)

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    new_item = Item.find_by(id: id)

    expect(response).to be_successful

    expect(new_item.name).to_not eq(old_name)
    expect(new_item.name).to eq("fork")

    expect(new_item.description).to_not eq(old_description)
    expect(new_item.description).to eq("eat with this utensil.")

    expect(new_item.unit_price).to_not eq(old_unit_price)
    expect(new_item.unit_price).to eq(0.99)
  end

  it "gets the merchant associated with the item" do
    merchant = create(:merchant)
    merchant.create(:item)
    binding.pry
  end
end
