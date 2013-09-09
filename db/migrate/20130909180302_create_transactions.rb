class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :title
      t.integer :category_id
      t.date :date
      t.decimal :amount

      t.timestamps
    end
  end
end
