class Product < ApplicationRecord
    validates :name, presence: true
    validates :cooking_time, presence: true
    validates :price, presence: true
    validates :is_available, presence: true
    has_one_attached :image  

    def self.ransackable_attributes(auth_object = nil)
        ["cooking_time", "created_at", "id", "is_available", "name", "order_id", "price", "updated_at"]
    end

    #validate :check_file_presence 
    #def check_file_presence
    #    errors.add(:image, "no file added") unless image.attached?
    #end
end
