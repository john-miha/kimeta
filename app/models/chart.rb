class Chart < ApplicationRecord
    has_many :evaluations, dependent: :destroy
    validates :title, presence: true
    
end
