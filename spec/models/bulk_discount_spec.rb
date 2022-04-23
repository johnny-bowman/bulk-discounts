require "rails_helper"

RSpec.describe BulkDiscount do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    
    @bd_1 = @merch_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 10)
  end

  describe "relationships" do
    it { should belong_to(:merchant) }
  end

  describe "validations" do
    it { should validate_numericality_of(:percent_discount)}
    it { should validate_numericality_of(:quantity_threshold)}
  end
end
