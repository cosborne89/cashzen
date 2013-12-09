class Transaction < ActiveRecord::Base
    belongs_to :budget
    belongs_to :category
    belongs_to :user
    
    before_save :eval_amount
    before_save :find_or_create_budget
    after_save :update_budget

    after_destroy :remove_from_assoc
    
    validates_presence_of :raw_amount, :category_id
    
    def find_or_create_budget
        @budget = self.category.budgets.where(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year).first
        unless @budget
            @budget = Budget.create(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year, title: self.category.title, remaining: self.category.monthly_spend, initial: self.category.monthly_spend)
        end
        self.budget_id = @budget.id.to_i
    end
    
    def remove_from_assoc
        self.budget.save!
    end

    def eval_amount
        self.amount = eval(self.raw_amount)
    end

    def update_budget
        self.category.budgets.where(date: self.date.beginning_of_month).first.save!
    end
end
