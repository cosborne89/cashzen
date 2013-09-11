class Budget < ActiveRecord::Base
    has_many :transactions
    belongs_to :category
    
    before_save :update_remaining
    after_save :update_category
    
    def update_remaining
        self.remaining = self.initial - self.transactions.to_a.sum(&:amount)
        #self.net_cash = self.initial_cash - self.monthly_remaining
    end
    
    def update_category
        self.category.save!
    end
end
