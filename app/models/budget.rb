class Budget < ActiveRecord::Base
    has_many :transactions, :dependent => :destroy
    belongs_to :category
    belongs_to :user

    accepts_nested_attributes_for :transactions, :allow_destroy => true
    
    before_save :update_remaining
    before_save :set_date_from_month_and_year
    after_save :update_category
    
    def update_remaining
        self.remaining = self.initial.to_f - self.transactions.sum(:amount)
        #self.net_cash = self.initial_cash - self.monthly_remaining
    end
    
    def set_date_from_month_and_year
        self.date = Date.new(self.year, self.month, 1)
    end
    
    def update_category
        self.category.save!
    end
end
