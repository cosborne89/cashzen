class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :title
      t.decimal :remaining
      t.integer :month
      t.integer :year
      t.text :tranaction_ids
      t.integer :category_id
      t.integer :user_id
      t.decimal :initial

      t.timestamps
    end
    rename_column :budgets, :tranaction_ids, :transaction_ids
  end
end
