class OrderDetail < ApplicationRecord
  enum is_production: { no: 0, wait: 1, continue: 2, complete: 3 }
  belongs_to :order
  belongs_to :item
  
  def subtotal
    price * amount
  end
  
end
