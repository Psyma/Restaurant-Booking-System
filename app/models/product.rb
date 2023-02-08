class Product < ApplicationRecord
    validates :name, presence: true
    validates :cooking_time, presence: true
    validates :price, presence: true
    validates :is_available, presence: true
    has_one_attached :image 

    #validate :check_file_presence 
    #def check_file_presence
    #    errors.add(:image, "no file added") unless image.attached?
    #end
end
