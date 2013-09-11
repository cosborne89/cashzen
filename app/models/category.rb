class Category < ActiveRecord::Base
    belongs_to :user
    has_many :budgets
    has_many :transactions, :through => :budgets
    
    scope :is_spree, -> { where(spree: true) }
    scope :basic, -> { where(spree: false) }
    
   # before_save :update_cash
    
    def update_cash
        self.net_cash = self.initial_cash + self.budgets.to_a.sum(&:remaining) if self.budgets
    end
        
        

end
