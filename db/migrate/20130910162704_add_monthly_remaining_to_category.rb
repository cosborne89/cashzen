class AddMonthlyRemainingToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :initial_cash, :decimal
    add_column :categories, :date, :date
    add_column :categories, :budget_ids, :text
    add_column :transactions, :budget_id, :text
    

  end
end
