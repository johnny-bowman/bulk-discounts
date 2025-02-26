class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @holidays = HolidayFacade.create_holidays
  end

  def show
    @bd = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bd = @merchant.bulk_discounts.create(discount_params)

    if bd.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
    end
  end

  def delete
    @merchant = Merchant.find(params[:merchant_id])

    BulkDiscount.find(params[:id]).destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  def edit
    @bd = BulkDiscount.find(params[:id])
  end

  def update
    bd = BulkDiscount.find(params[:id])
    bd.update(discount_params)
    bd.save

    redirect_to "/bulk_discounts/#{bd.id}"
  end

  private

  def discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
