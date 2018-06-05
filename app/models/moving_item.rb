class MovingItem < ApplicationRecord
  belongs_to :allocation, inverse_of: :moving_items
  belongs_to :destination, class_name: 'Allocation', optional: true
  belongs_to :replace, class_name: 'EquipmentItem', optional: true

  has_many :moving_tasks, dependent: :destroy

  validates :description, :qty, :allocation_id, presence: true
  validates :qty, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :weight, :volume, numericality: { greater_than: 0 }, allow_nil: true

  accepts_nested_attributes_for :moving_tasks, allow_destroy: true 
end
