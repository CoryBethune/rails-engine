class ItemSerializer
  def self.format_items(data)
    {
      data: data.map do |item|
        {
          id: item.id.to_s,
          type: 'item',
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  def self.one_item(data)
    {
      data: {
        id: data.id.to_s,
        type: 'item',
        attributes: {
          name: data.name,
          description: data.description,
          unit_price: data.unit_price,
          merchant_id: data.merchant_id
        }
      }
    }
  end
end
