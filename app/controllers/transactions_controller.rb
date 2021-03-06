class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  #layout "mobile_layout", only: [:mobile]

  # GET /transactions
  # GET /transactions.json
  def index
    if current_user.transactions.exists?
      @transactions = current_user.transactions.order(date: :desc).paginate(:page => params[:page], :per_page => 15)
    end
  end

  def mobile
    @transaction = Transaction.new  
    render layout: "mobile_layout"
  end


  def multiadd
    @transaction = Transaction.new
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end


  # GET /transactions/new
  def new
      if params[:category_id]
        @transaction = Transaction.new(:category_id => params[:category_id])
      else
        @transaction = Transaction.new  
      end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to request.referrer, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:title, :category_id, :date, :input_date, :raw_amount, :amount, :budget_id, :user_id)
    end
end
