class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @bd = BulkDiscount.find(params[:id])
  end
end
