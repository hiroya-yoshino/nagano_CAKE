class OrderDetail < ApplicationRecord
  enum is_production: { not_start: 0, wait_making: 1, now_making: 2, complete_making: 3 }
  belongs_to :order
  belongs_to :item

  def subtotal
    price * amount
  end

end
