class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.categories
    @years = []
    @months = []
    @categories.each do |category|
      @budgets = category.budgets
      @budgets.each do |budget|
          @years << budget.year
          @months << budget.month
      end
    end
    @years = @years.uniq.map(&:to_i).sort
    @months = @months.uniq.map(&:to_i).sort
    @balance =  @categories.income.to_a.sum(&:monthly_spend) - @categories.not_income.to_a.sum(&:monthly_spend) unless @categories.income.blank?
    unless @categories.income.blank?
      @debt_to_income = @categories.debt.to_a.sum(&:monthly_spend)/@categories.income.to_a.sum(&:monthly_spend) unless @categories.debt.blank?
      @savings_to_income = @categories.savings.to_a.sum(&:monthly_spend)/@categories.income.to_a.sum(&:monthly_spend) unless @categories.savings.blank?
    end
    unless @categories.not_income.blank?
        @needs = (@categories.not_income.needs.to_a.sum(&:monthly_spend))/@categories.not_income.to_a.sum(&:monthly_spend) unless @categories.needs.blank?
        @wants = @categories.wants.to_a.sum(&:monthly_spend)/@categories.not_income.to_a.sum(&:monthly_spend) unless @categories.wants.blank?
        @saves = @categories.saves.to_a.sum(&:monthly_spend)/@categories.not_income.to_a.sum(&:monthly_spend) unless @categories.saves.blank?
    end
  end
  
  def accrued
    @categories = current_user.categories
    @years = []
    @months = []
    @categories.each do |category|
      @budgets = category.budgets
      @budgets.each do |budget|
          @years << budget.year
          @months << budget.month
      end
    end
    @years = @years.uniq.map(&:to_i).sort
    @months = @months.uniq.map(&:to_i).sort
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
      @budgets = @category.budgets.order(date: :asc)
      @years = @budgets.map(&:year).uniq
      @months = @budgets.map(&:month).uniq
      dates = []
      remainings = []
      accrued = []
      cumulative = @category.initial_cash
      @budgets.each do |budget|
          @month_name = month_name(budget.month)
          dates << "#{month_name(budget.month)[0..2]}, #{budget.year}"
          remainings << budget.remaining.to_f
          cumulative = cumulative+budget.remaining
          accrued << cumulative.to_f
      end
      gon.dates = dates
      gon.number_dates = @budgets.count
      gon.remainings = remainings
      gon.accrued = accrued
  end

  # GET /categories/new
  def new
      case params[:classification]
      when "Income"
        @category = Category.new(:classification => "Income")
      when "Fixed Expense"
        @category = Category.new(:classification => "Fixed Expense")
      when "Occasional Expense"
        @category = Category.new(:classification => "Occasional Expense")
      when "Variable Expense"
        @category = Category.new(:classification => "Variable Expense")
      when "Debt Payment"
        @category = Category.new(:classification => "Debt Payment")
      when "Transfer to Savings"
        @category = Category.new(:classification => "Transfer to Savings")
      when "Spree"
        @category = Category.new(:classification => "Spree")
      else 
        @category = Category.new
      end
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = current_user.categories.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :monthly_spend, :net_cash, :user_id, :created_at, :updated_at, :initial_cash, :frequency, :classification, :need_type, :order)
    end

        
end
