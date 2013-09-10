class Category < ActiveRecord::Base
    belongs_to :user
    has_many :transactions
    
    scope :is_spree, -> { where(spree: true) }
    scope :basic, -> { where(spree: false) }
    
    before_save :update_cash
    
    def update_cash
        self.monthly_remaining = self.monthly_spend - self.transactions.to_a.sum(&:amount)
        self.net_cash = self.net_cash + self.monthly_spend - self.transactions.to_a.sum(&:amount)
    end
    
    def monthly_reset
        self.net_cash += self.monthly_remaining
        self.monthly_remaining = self.monthly_spend
    end
end
