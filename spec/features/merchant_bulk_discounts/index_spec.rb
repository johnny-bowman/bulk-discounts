require "rails_helper"

RSpec.describe "BulkDiscounts index page" do
  before :each do
    @merch_1 = Merchant.create!(name: "Two-Legs Fashion")
    @merch_2 = Merchant.create!(name: "Two-Legs Fashion")

    @bd_1 = @merch_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 10)
    @bd_2 = @merch_1.bulk_discounts.create!(percent_discount: 30, quantity_threshold: 15)
    @bd_3 = @merch_1.bulk_discounts.create!(percent_discount: 40, quantity_threshold: 20)

    @bd_4 = @merch_2.bulk_discounts.create!(percent_discount: 50, quantity_threshold: 25)

    visit "/merchants/#{@merch_1.id}/bulk_discounts"
  end

  it "displays all bulk discounts for merchant" do
    # save_and_open_page
    expect(page).to have_content("Percent Discount: 20 Quantity Threshold: 10")
    expect(page).to have_content("Percent Discount: 30 Quantity Threshold: 15")
    expect(page).to have_content("Percent Discount: 40 Quantity Threshold: 20")

    expect(page).to_not have_content("Percent Discount: 50 Quantity Threshold: 50")
  end

  it "has links to each discount show page" do
    within("##{@bd_1.id}") do
      click_link("View This Discount")

      expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts/#{@bd_1.id}")
    end
  end

  it "has link to create new discount" do
    click_link("Create New Discount")

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts/new")
  end

  it "has link to delete bulk discount" do
    expect(page).to have_content("Percent Discount: 20 Quantity Threshold: 10")

    within("##{@bd_1.id}") do
      click_link("Delete This Discount")
    end

    expect(current_path).to eq("/merchants/#{@merch_1.id}/bulk_discounts")
    expect(page).to_not have_content("Percent Discount: 20 Quantity Threshold: 10")
  end
end
