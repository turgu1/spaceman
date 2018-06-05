# A Building is composed of one to many wings. Each wing may have many floors.
# The user can decide the order to present the floors.

class Wing < ApplicationRecord
  belongs_to :building, inverse_of: :wings
  has_many :floors, -> { order(:order, :name) }, inverse_of: :wing, dependent: :nullify

  validates :name, :short_name, :building_id, presence: true
  validates :name,  uniqueness: { scope: :building_id }
  validates :order, numericality: { only_integer: true }

  def complete_name
    my_name = self.visible? ? " / #{self.name}" : ''
    "#{self.building.name}#{my_name}"
  end

  def complete_short_name
    my_name = self.visible? ? " / #{self.short_name}" : ''
    "#{self.building.short_name}#{my_name}"
  end

  def building_name
    self.building.name
  end
end
