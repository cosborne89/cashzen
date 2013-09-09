# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin1 = User.new(
  email: 'admin1@admin.com',
  role: 'admin', 
  password: 'admin!',
  password_confirmation: 'admin!'
)
admin1.skip_confirmation!
admin1.save!

category1 = Category.new(
    title: 'Groceries',
    monthly_spend: 515,
    reset_on: 1,
    net_cash: 150,
    user_id: 1,
    transaction_ids: []
    )
category1.skip_confirmation!
category1.save!

transaction1 = Transaction.new(
    title: 'Harris Teeter',
    category_id: 1,
    date: "09/09/2013",
    amount = 125.00
)
transaction1.skip_confirmation!
transaction1.save!