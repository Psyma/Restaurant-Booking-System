class Comment < ApplicationRecord
    validates :contents, presence: true
end
