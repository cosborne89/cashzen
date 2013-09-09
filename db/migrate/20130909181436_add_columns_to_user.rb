class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :category_ids, :text
    add_column :users, :transaction_ids, :text
    add_column :transactions, :user_id, :integer
  end
end
