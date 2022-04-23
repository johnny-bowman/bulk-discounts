class BulkDiscount < ApplicationRecord
  validates :percent_discount, presence: true, numericality: true
  validates :quantity_threshold, presence: true, numericality: true

  belongs_to :merchant
end
