class Enetvent < ApplicationRecord
    has_many :events, dependent: :destroy
end
