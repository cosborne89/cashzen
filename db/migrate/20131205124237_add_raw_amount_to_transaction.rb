class AddRawAmountToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :raw_amount, :string
  end
end
