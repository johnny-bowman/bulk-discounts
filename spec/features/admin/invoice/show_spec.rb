require "rails_helper"

RSpec.describe "Invoice Show Page" do
  before :each do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
    )
    @merchant_2 = Merchant.create!(
      name: "Erots",
    )
    @cup = @merchant_1.items.create!(
      name: "Cup",
      description: "What the **** is this thing?",
      unit_price: 10000,
    )
    @soccer = @merchant_1.items.create!(
      name: "Soccer Ball",
      description: "A ball of pure soccer.",
      unit_price: 32000,
    )
    @beer = @merchant_2.items.create!(
      name: "Beer",
      description: "Happiness <3",
      unit_price: 100,
    )
    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
    )
    @customer_2 = Customer.create!(
      first_name: "Jimmy",
      last_name: "Felony",
    )
    @invoice_1 = @customer_1.invoices.create!(
      status: 1,
      created_at: Date.new(2020, 12, 12),
      updated_at: Date.current
    )
    @invoice_2 = @customer_1.invoices.create!(
      status: 2,
    )
    @invoice_3 = @customer_2.invoices.create!(
      status: 0,
    )
    @invoice_item_1 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 1,
      unit_price: @soccer.unit_price,
      status: 1,
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @cup.unit_price,
      status: 1,
    )
    @invoice_item_3 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_2.id,
      quantity: 500,
      unit_price: @soccer.unit_price,
      status: 0,
    )
    @invoice_item_4 = InvoiceItem.create!(
      item_id: @beer.id,
      invoice_id: @invoice_3.id,
      quantity: 2,
      unit_price: @beer.unit_price,
      status: 0,
    )
    @transaction_1 = @invoice_1.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "success"
    )
    @transaction_2 = @invoice_2.transactions.create!(
      credit_card_number: "4654405418249632",
      result: "failed"
    )

    @bd_1 = @merchant_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 50)
    @bd_2 = @merchant_1.bulk_discounts.create!(percent_discount: 30, quantity_threshold: 60)
    @bd_3 = @merchant_1.bulk_discounts.create!(percent_discount: 40, quantity_threshold: 70)

    visit "/admin/invoices/#{@invoice_1.id}"
  end

  it "contains information about the invoice", :vcr do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content("Saturday, December 12, 2020")
    expect(page).to have_content("Malcolm Jordan")
  end

  it "displays invoice item info", :vcr do
    within("#ii-#{@invoice_item_1.id}") do
      expect(page).to have_content("Soccer Ball")
      expect(page).to have_content("Quantity: 1")
      expect(page).to have_content("Sold for: $320.0 each")
      expect(page).to have_content("Status: packaged")
    end
  end

  it "displays the total revenue to be made after bulk discounts", :vcr do
    within("#total_discount_revenue") do
      expect(page).to have_content("Total After Bulk Discounts: $4320.0")
    end
  end
end
