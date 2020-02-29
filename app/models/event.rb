class Event < ApplicationRecord
    belongs_to :enetvent
    has_many :options, dependent: :destroy
    validates_uniqueness_of :title, :scope => :date
end
