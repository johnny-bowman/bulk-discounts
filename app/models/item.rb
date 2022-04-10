class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :created_at, presence: true
  validates :updated_at, presence: true

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
end
