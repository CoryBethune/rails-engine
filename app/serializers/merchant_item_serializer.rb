class MerchantItemSerializer
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
end
