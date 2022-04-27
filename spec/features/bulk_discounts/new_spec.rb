require "rails_helper"

RSpec.describe "BulkDiscounts new page" do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")

    @bd_1 = @merch_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 10)

    visit "/merchants/#{@merch_1.id}/bulk_discounts"
  end

  it "has form to create new bulk discount" do
    visit "/merchants/#{@merch_1.id}/bulk_discounts"

    expect(page).to have_content("Percent Discount: 20 Quantity Threshold: 10")
    expect(page).to_not have_content("Percent Discount: 27 Quantity Threshold: 8")

    visit "/merchants/#{@merch_1.id}/bulk_discounts/new"

    fill_in "Percent discount", with: 27
    fill_in "Quantity threshold", with: 8
    click_button "Create Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts")

    expect(page).to have_content("Percent Discount: 20 Quantity Threshold: 10")
    expect(page).to have_content("Percent Discount: 27 Quantity Threshold: 8")
    
    visit "/merchants/#{@merch_1.id}/bulk_discounts/new"

    click_button "Create Bulk Discount"

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts/new")
  end
end
