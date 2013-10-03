class Budget < ActiveRecord::Base
    has_many :transactions
    belongs_to :category
    belongs_to :user
    
    before_save :update_remaining
    before_save :set_date_from_month_and_year
    after_save :update_category
    
    def update_remaining
        self.remaining = self.initial - self.transactions.to_a.sum(&:amount)
        #self.net_cash = self.initial_cash - self.monthly_remaining
    end
    
    def set_date_from_month_and_year
        self.date = Date.new(self.year, self.month, 1)
    end
    
    def update_category
        self.category.save!
    end
end
