class EquipmentItem < ApplicationRecord
  belongs_to :itemable, polymorphic: true
  belongs_to :equipment_model

  validates :equipment_model_id, presence: true
  validates :qty, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # The name of the equipment item is in fact the name of the equipment model.
  def name
    self.equipment_model.try(:name)
  end

  # The photo come also from the equipment model.
  def photo
    self.equipment_model.try(:photo)
  end
end
