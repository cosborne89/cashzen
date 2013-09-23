class ChangeCategoryColumnsAa < ActiveRecord::Migration
  def change
      remove_column :categories, :reset_on
      remove_column :categories, :date
      change_column :categories, :initial_cash, :decimal, default: 0
  end
end
