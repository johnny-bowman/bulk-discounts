require "rails_helper"

RSpec.describe InvoiceItem do
  describe "relationships" do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  it "returns discounts applied to invoice" do
    @merchant_1 = Merchant.create!(
      name: "Store Store",
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

    @customer_1 = Customer.create!(
      first_name: "Malcolm",
      last_name: "Jordan",
    )

    @invoice_1 = @customer_1.invoices.create!(
      status: 1
    )

    @invoice_item_1 = InvoiceItem.create!(
      item_id: @cup.id,
      invoice_id: @invoice_1.id,
      quantity: 50,
      unit_price: @soccer.unit_price,
      status: 1
    )
    @invoice_item_2 = InvoiceItem.create!(
      item_id: @soccer.id,
      invoice_id: @invoice_1.id,
      quantity: 60,
      unit_price: @cup.unit_price,
      status: 1
    )

    @bd_1 = @merchant_1.bulk_discounts.create!(percent_discount: 20, quantity_threshold: 50)
    @bd_2 = @merchant_1.bulk_discounts.create!(percent_discount: 30, quantity_threshold: 60)

    expect(@invoice_item_1.applied_discounts).to eq(@bd_1)
    expect(@invoice_item_2.applied_discounts).to eq(@bd_2)
  end
end
