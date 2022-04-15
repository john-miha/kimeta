class Evaluation < ApplicationRecord
  belongs_to :chart
  has_many :viewpoints
  has_many :items
end
