class MerchantSerializer
  def self.format_merchants(data)
    {
      data: data.map do |merchant|
        {
          id: merchant.id.to_s,
          type: "merchant",
          attributes: {
            name: merchant.name
          }
        }
      end
    }
  end

  def self.one_merchant(data)
    {
      data: {
        id: data.id.to_s,
        type: 'merchant',
        attributes: {
          name: data.name
        }
      }
    }
  end
end
