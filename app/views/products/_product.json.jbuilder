json.extract! product, :id, :name, :cooking_time, :price, :is_available, :created_at, :updated_at
json.url product_url(product, format: :json)
