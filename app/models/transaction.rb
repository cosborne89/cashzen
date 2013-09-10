class Transaction < ActiveRecord::Base
    belongs_to :category
    belongs_to :user
    
    after_save :update_category
    
    def update_category
        self.category.save!
    end

end
