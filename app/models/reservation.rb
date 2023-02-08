class Reservation < ApplicationRecord
    has_one :user
    has_one :order
end
