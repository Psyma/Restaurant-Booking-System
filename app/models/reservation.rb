class Reservation < ApplicationRecord
    has_one :order
end
