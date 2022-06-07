class Chart < ApplicationRecord
    has_many :evaluations, dependent: :destroy
    belongs_to :user, optional: true
    validates :title, presence: true
    
end
