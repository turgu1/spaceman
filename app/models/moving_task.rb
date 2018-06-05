class MovingTask < ApplicationRecord
  belongs_to :specialty
  belongs_to :moving_item

  validates :name, :order, presence: true
  validates :order, numericality: { only_integer: true }
end
