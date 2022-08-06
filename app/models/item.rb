class Item < ApplicationRecord
  has_one_attached :image
  
  belongs_to :genre
  
  def get_image
    profile_image.variant(resize_to_limit[100,100]).processed
  end
  
end
