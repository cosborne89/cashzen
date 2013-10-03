class AddDateToBudgets < ActiveRecord::Migration
  def change
    add_column :budgets, :date, :date
  end
end
