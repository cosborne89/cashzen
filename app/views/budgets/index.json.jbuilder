json.array!(@budgets) do |budget|
  json.extract! budget, :title, :remaining, :date
  json.url budget_url(budget, format: :json)
end
