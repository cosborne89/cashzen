class AddColumnsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :frequency, :string
    add_column :categories, :classification, :string
    add_column :categories, :need_type, :string
    remove_column :categories, :spree, :boolean
  end
end
