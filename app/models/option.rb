class Option < ApplicationRecord
    belongs_to :event
    has_many :bets, dependent: :destroy
end
