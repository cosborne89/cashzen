class Transaction < ActiveRecord::Base
    belongs_to :budget
    belongs_to :category
    belongs_to :user
    
    before_save :set_date
    before_save :eval_amount
    before_save :create_title
    before_save :find_or_create_budget
    after_save :update_budget

    after_destroy :remove_from_assoc
    
    validates_presence_of :raw_amount, :category_id

    attr_accessor :input_date

    def set_date
        if self.input_date
            self.date = Date.strptime(self.input_date, "%m/%d/%Y")
        #if input_date is passed, then you are not using mobile, therefore you need to set the date here.
        #even if date exists, you may still pass input_date during an edit, so you can't do unless self.date
        end
    end


    def find_or_create_budget
        @budget = self.category.budgets.where(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year).first
        unless @budget
            @budget = Budget.create(category_id: self.category_id, user_id: self.user_id, month: self.date.month, year: self.date.year, title: self.category.title, remaining: self.category.monthly_spend, initial: self.category.monthly_spend)
        end
        self.budget_id = @budget.id.to_i
    end
    
    def create_title
        if self.title.blank?
            self.title = "#{ActionController::Base.helpers.number_to_currency(self[:amount])} on #{self.date} in #{self.category.title}"
            #this violates MVC, which says that view formatting should be done in the view, but I would rather do this calculation once than many times.
        end
    end

    def remove_from_assoc
        self.budget.save!
    end

    def eval_amount
        self.amount = eval(self.raw_amount.tr("$", ''))
    end

    def update_budget
        self.category.budgets.where(date: self.date.beginning_of_month).first.save!
    end
end
