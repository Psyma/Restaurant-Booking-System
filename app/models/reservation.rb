class Reservation < ApplicationRecord
    validates :date, presence: true
    has_one :order

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "date", "id", "status", "updated_at", "user_id", "order", "first_name"]
    end 
end
