class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum atatus: { wait: 0, confirm: 1, continue: 2, preparation: 3, complete: 4 }

end
