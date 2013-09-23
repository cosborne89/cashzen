class Category < ActiveRecord::Base
    belongs_to :user
    has_many :budgets
    has_many :transactions, :through => :budgets
    

    scope :fixed, -> { where(classification: "Fixed Expense") }
    scope :variable, -> { where(classification: "Variable Expense") }
    scope :occasional, -> { where(classification: "Occasional Expense") }
    scope :debt, -> { where(classification: "Debt Payment") }
    scope :savings, -> { where(classification: "Transfer to Savings") }
    scope :income, -> { where(classification: "Income") }
    scope :spree, -> { where(classification: "Spree") }
    scope :monthly, -> { where(frequency: "Monthly") }
    scope :occasional, -> { where(frequency: "Occasional") }
    scope :single, -> { where(frequency: "Single") }
    
    
    Classification = ["Fixed Expense", "Variable Expense", "Occasional Expense", "Debt Payment", "Transfer to Savings", "Income", "Spree"]
    NeedSaveWant = ["Need","Want","Save"]
    
    
    
    before_save :update_cash
    before_save :set_frequency
    
    def update_cash
        if self.net_cash.blank?
            self.net_cash = 0
        end
        self.net_cash = self.initial_cash + self.budgets.to_a.sum(&:remaining) if self.budgets
    end
        
    def set_frequency
        if self.classification == "Fixed Expense" || self.classification == "Variable Expense" || self.classification == "Income" || self.classification == "Debt Payment" || self.classification == "Transfer To Savings"
            self.frequency = "Monthly"
        elsif self.classification == "Occasional Expense" 
            self.frequency = "Occasional"
        else
            self.frequency = "Single"
        end
    end
end
