class BillsController < ApplicationController
  before_filter :get_dwelling_and_bill

  # GET /bills
  # GET /bills.json
  def index
    @bills = current_dwelling.bills

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    @bill = Bill.new
    @bill.dwelling = current_dwelling

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(params[:bill])
    @bill.dwelling = current_dwelling
    
    respond_to do |format|
      if @bill.save
        format.html { redirect_to bill_path(@bill), notice: 'Bill was successfully created.' }
        format.json { render json: @bill, status: :created, location: @bill }
      else
        format.html { render action: "new" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to bill_path(@bill), notice: 'Bill was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_path }
      format.json { head :no_content }
    end
  end

  def get_dwelling_and_bill
    @dwelling = current_dwelling
    if params[:id]
      @bill = @dwelling.bills.find(params[:id])
    end
  end
end
