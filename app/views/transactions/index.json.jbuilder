json.array!(@transactions) do |transaction|
  json.extract! transaction, :title, :category_id, :date, :amount
  json.url transaction_url(transaction, format: :json)
end
