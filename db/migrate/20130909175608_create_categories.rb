class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.decimal :monthly_spend
      t.text :transaction_ids
      t.integer :reset_on
      t.decimal :net_cash
      t.integer :user_id
      t.boolean :spree

      t.timestamps
    end
  end
end
