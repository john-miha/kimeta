class Chart < ApplicationRecord
    has_many :evaluations, dependent: :destroy
end
