class BillPaymentsController < ApplicationController
  before_filter :get_references

  # List all payments made by current_user
  # GET /bill_payments
  def history
    @bill_payments = @user.bill_payments.all
    respond_to do |format|
      format.html # history.html.erb
    end
  end

  # List all payments made on this bill
  def index
    @bill_payments = @bill.bill_payments.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # Show details of a particular payment
  # GET /bill/:bill_id/bill_payments/:id
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /bills/:bill_id/bill_payments/new
  # GET /bills/:bill_id/bill_payments/new.json
  def new
    @bill_payment = BillPayment.new
    @bill_payment.bill = @bill
    @bill_payment.user = @user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill_payment }
    end
  end

  # GET /bills/:bill_id/bill_payments/:id/edit
  def edit
  end

  # POST /bills/:bill_id/bill_payments
  # POST /bills/:bill_id/bill_payments.json
  def create
    @bill_payment = BillPayment.new(params[:bill_payment])
    @bill_payment.bill = @bill
    @bill_payment.user = @user

    respond_to do |format|
      if @bill_payment.save
        format.html { redirect_to bill_path(@bill), notice: 'Payment transaction was successfull.' }
        format.json { render json: @bill_payment, status: :created, location: @bill_payment }
      else
        format.html { render :new }
        format.json { render json: @bill_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/:bill_id/bill_payments/:id
  # PUT /bills/:bill_id/bill_payments/:id.json
  def update
    respond_to do |format|
      if @bill_payment.update_attributes(params[:bill_payment])
        format.html { redirect_to bill_path(@bill), notice: 'Bill Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @bill_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/:bill_id/bill_payment/:id
  def destroy
    @bill_payment.destroy

    respond_to do |format|
      format.html { redirect_to bills_path }
      format.json { head :no_content }
    end
  end

  def get_references
    @dwelling = current_dwelling
    @user = current_user
    if params[:bill_id]
      @bill = @dwelling.bills.find(params[:bill_id])
      if params[:id]
        @bill_payment = @bill.bill_payments.find(params[:id])
      end
    end
  end
end
