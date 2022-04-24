require "rails_helper"

RSpec.describe "BulkDiscounts edit page" do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @bd_1 = @merch_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 10)
  end

  it "edits a bulk discount" do
    visit "/merchants/#{@merch_1.id}/bulk_discounts/#{@bd_1.id}?merchant_id=#{@merch_1.id}"
    
    expect(page).to have_content("Percent Discount: 20\nQuantity Threshold: 10")
    expect(page).to_not have_content("Percent Discount: 24\nQuantity Threshold: 13")

    click_link "Edit Discount"

    fill_in "Percent discount", with: 24
    fill_in "Quantity threshold", with: 13
    click_button "Update Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts/#{@bd_1.id}")

    expect(page).to have_content("Percent Discount: 24\nQuantity Threshold: 13")
    expect(page).to_not have_content("Percent Discount: 20\nQuantity Threshold: 10")
  end
end
