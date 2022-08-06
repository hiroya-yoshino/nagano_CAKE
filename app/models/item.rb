class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :genre

  def get_image
    self.image.variant(resize_to_fill: [100,100]).processed
  end

end