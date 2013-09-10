class AddMonthlyRemainingToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :monthly_remaining, :decimal
  end
end
