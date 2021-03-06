class Category < ActiveRecord::Base
    belongs_to :user
    has_many :budgets, :dependent => :destroy
    has_many :transactions, :through => :budgets
    accepts_nested_attributes_for :transactions, :allow_destroy => true
    

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
    before_save :modify_this_months_budget
    
    def self.for_select(user_id)
        {
          'Income'   => where(:user_id => user_id, :classification => "Income" ).map { |p| [p.title, p.id] },
          'Variable Expense'   => where(:user_id => user_id, :classification => "Variable Expense" ).map { |p| [p.title, p.id] },
          'Fixed Expense'   => where(:user_id => user_id, :classification => "Fixed Expense" ).map { |p| [p.title, p.id] },
          'Occasional Expense'   => where(:user_id => user_id, :classification => "Occasional Expense" ).map { |p| [p.title, p.id] },
          'Debt Payment'   => where(:user_id => user_id, :classification => "Debt Payment" ).map { |p| [p.title, p.id] },
          'Transfer to Savings'   => where(:user_id => user_id, :classification => "Transfer to Savings" ).map { |p| [p.title, p.id] },
        }
    end
    
    
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
    
    def modify_this_months_budget
        @month = Date.today.month
        @year = Date.today.year
        self.budgets.where(year: @year, month: @month).first.initial = self.monthly_spend if self.budgets.where(year: @year, month: @month).first
        #self.budgets.where(year: @year, month: @month).first.save! if self.budgets.where(year: @year, month: @month).first
    end
        
end
