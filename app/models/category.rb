class Category < ActiveRecord::Base
    belongs_to :user
    has_many :budgets
    has_many :transactions, :through => :budgets
    

    scope :fixed, -> { where(classification: "Fixed Expense").order(monthly_spend: :desc) }
    scope :variable, -> { where(classification: "Variable Expense").order(monthly_spend: :desc)  }
    scope :occasional, -> { where(classification: "Occasional Expense").order(monthly_spend: :desc)  }
    scope :debt, -> { where(classification: "Debt Payment").order(monthly_spend: :desc)  }
    scope :savings, -> { where(classification: "Transfer to Savings").order(monthly_spend: :desc)  }
    scope :income, -> { where(classification: "Income").order(monthly_spend: :desc)  }
    scope :not_income, -> { where.not(classification: "Income").order(monthly_spend: :desc)  }
    scope :spree, -> { where(classification: "Spree").order(monthly_spend: :desc)  }
    scope :monthly, -> { where(frequency: "Monthly").order(monthly_spend: :desc)  }
    scope :occasional, -> { where(frequency: "Occasional").order(monthly_spend: :desc)  }
    scope :single, -> { where(frequency: "Single").order(monthly_spend: :desc)  }
    scope :needs, -> { where(need_type: "Need").order(monthly_spend: :desc)  }
    scope :wants, -> { where(need_type: "Want").order(monthly_spend: :desc)  }
    scope :saves, -> { where(need_type: "Save").order(monthly_spend: :desc)  }
    
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
