json.array!(@categories) do |category|
  json.extract! category, :title, :monthly_spend, :transaction_ids, :reset_on, :net_cash, :user_id, :spree
  json.url category_url(category, format: :json)
end
