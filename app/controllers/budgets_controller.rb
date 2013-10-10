class BudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_budget, only: [:show, :edit, :update, :destroy]

  # GET /budgets
  # GET /budgets.json
  def index
      #not really functioning as an index. this is functioning as a summary for this month.
      @budgets = Budget.where(year: Date.today.year, month: Date.today.month)
      @year = Date.today.year
      @month = Date.today.month
      gon.prop_spent = []
      gon.prop_remaining = []
      @budgets.each do |budget|
        gon.prop_spent << (budget.initial-budget.remaining)/budget.initial
        gon.prop_remaining << budget.remaining/budget.initial
      end
      gon.number_budgets = gon.prop_spent.count
  end

  def month
      #this is the calendar view
      @categories = current_user.categories
      @month = Date.today.month
      @year = Date.today.year
      @dates_in_month = 1..Time::days_in_month(@month)
      @budgets = current_user.budgets.where(month: @month)
      @transactions = current_user.transactions.where(date: Date.new(@year, @month, 1)..Date.new(@year,@month,31))
  end
  
  def summary_by_month
      #this is #index but for other months.
      @budgets = Budget.where(year: params[:year], month: params[:month])
      @year = params[:year]
      @month = params[:month]
      gon.prop_spent = []
      gon.prop_remaining = []
      @budgets.each do |budget|
        gon.prop_spent << (budget.initial-budget.remaining)/budget.initial
        gon.prop_remaining << budget.remaining/budget.initial
      end
      gon.number_budgets = gon.prop_spent.count
  end
  
  # GET /budgets/1
  # GET /budgets/1.json
  def show
      #functioning as a detailed look at this month (spending where)
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets
  # POST /budgets.json
  def create
    @budget = Budget.new(budget_params)

    respond_to do |format|
      if @budget.save
        format.html { redirect_to @budget, notice: 'Budget was successfully created.' }
        format.json { render action: 'show', status: :created, location: @budget }
      else
        format.html { render action: 'new' }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1
  # PATCH/PUT /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to @budget, notice: 'Budget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1
  # DELETE /budgets/1.json
  def destroy
    @budget.destroy
    respond_to do |format|
      format.html { redirect_to budgets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def budget_params
      params.require(:budget).permit(:title, :remaining, :month, :year, :transaction_ids, :category_id, :user_id, :date)
    end
end
