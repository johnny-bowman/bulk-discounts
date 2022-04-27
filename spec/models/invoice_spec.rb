require "rails_helper"

RSpec.describe Invoice do
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:transactions) }
    it { should belong_to(:customer) }
  end

  describe "validations" do
    it { should validate_presence_of(:status) }
  end

  describe "methods" do
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
        status: 1
      )
      @invoice_2 = @customer_1.invoices.create!(
        status: 2
      )
      @invoice_3 = @customer_2.invoices.create!(
        status: 0
      )

      @invoice_item_1 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_1.id,
        quantity: 1,
        unit_price: @soccer.unit_price,
        status: 1
      )
      @invoice_item_2 = InvoiceItem.create!(
        item_id: @cup.id,
        invoice_id: @invoice_1.id,
        quantity: 50,
        unit_price: @cup.unit_price,
        status: 1
      )
      @invoice_item_3 = InvoiceItem.create!(
        item_id: @soccer.id,
        invoice_id: @invoice_2.id,
        quantity: 500,
        unit_price: @soccer.unit_price,
        status: 0
      )

      @invoice_item_4 = InvoiceItem.create!(
        item_id: @beer.id,
        invoice_id: @invoice_3.id,
        quantity: 2,
        unit_price: @beer.unit_price,
        status: 2
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
    end

    describe "-instance" do
      it "calculates the total value for an invoice" do
        expect(@invoice_1.invoice_total).to eq(5320.0)
      end

      it "calculates total revenue for invoice with discounts" do
        expect(@invoice_1.discounted_rev).to eq(4320) # 50 cups @ $100 each, 20% off

        expect(@invoice_2.discounted_rev).to eq(96000) # 500 soccer balls @ $320 each, 40% off
      end

      it "returns discounts applied to invoice" do
        expect(@invoice_1.applied_discounts).to eq(@bd_1)
      end

      it "determines if there are any unshipped invoice items" do
        expect(@invoice_3.has_items_not_shipped).to eq(true)
        expect(@invoice_1.has_items_not_shipped).to eq(false)
      end
    end

    describe "-class" do
      it "orders invoices by oldest to newest" do
        expect(Invoice.oldest_first).to eq([@invoice_1, @invoice_2, @invoice_3])
      end
    end
  end
end
