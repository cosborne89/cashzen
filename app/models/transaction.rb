class Transaction < ActiveRecord::Base
    belongs_to :budget
    belongs_to :category
    belongs_to :user
    
    before_save :find_or_create_budget
    after_save :update_budget
    
    validates_presence_of :amount, :category_id
    
    def find_or_create_budget
        @budget = self.category.budgets.where(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year).first
        unless @budget
            @budget = Budget.create(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year, title: self.category.title, remaining: self.category.monthly_spend, initial: self.category.monthly_spend)
        end
        self.budget_id = @budget.id.to_i
    end
    
    def update_budget
         self.category.budgets.where(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year, title: self.category.title).first.save!
    end
end
