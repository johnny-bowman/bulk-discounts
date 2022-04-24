class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @bd = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    bd = @merchant.bulk_discounts.create!(discount_params)

    if bd.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{@merch_1.id}/bulk_discounts/new"
    end
  end

  def delete
    @merchant = Merchant.find(params[:merchant_id])

    BulkDiscount.find(params[:id]).destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  private

  def discount_params
    params.permit(:percent_discount, :quantity_threshold)
  end
end
