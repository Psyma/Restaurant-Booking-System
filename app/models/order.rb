class Order < ApplicationRecord
    belongs_to :reservation
    has_many :products
end
