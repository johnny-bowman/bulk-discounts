require "rails_helper"

RSpec.describe "BulkDiscounts show page" do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "Two-Legs Fashion")

    @bd_1 = @merch_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 10)
    @bd_2 = @merch_1.bulk_discounts.create!(percent_discount: 30, quantity_threshold: 15)
    @bd_3 = @merch_1.bulk_discounts.create!(percent_discount: 40, quantity_threshold: 20)

    @bd_4 = @merch_2.bulk_discounts.create!(percent_discount: 50, quantity_threshold: 25)

    visit "/merchants/#{@merch_1.id}/bulk_discounts/#{@bd_1.id}?merchant_id=#{@merch_1.id}"
  end

  it "displays discount quantity_threshold and percent_discount" do
    expect(page).to have_content("Percent Discount: 20\nQuantity Threshold: 10")
  end

  it "has link to edit discount" do
    click_link("Edit Discount")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts/#{@bd_1.id}/edit")
  end
end
