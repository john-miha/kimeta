class Evaluation < ApplicationRecord
  belongs_to :chart
  has_many :viewpoints, dependent: :destroy
  has_many :items, dependent: :destroy
end
