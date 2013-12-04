class ChangeTransactionsA < ActiveRecord::Migration
  def change
  	connection.execute(%q{
    alter table transactions
    alter column budget_id
    type integer using cast(budget_id as integer)
  	})
  	#change_column :transactions, :budget_id, :integer
  end
end
