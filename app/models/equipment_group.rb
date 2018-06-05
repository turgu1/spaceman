class EquipmentGroup < ApplicationRecord
  belongs_to :equipment_group, foreign_key: :parent, optional: true
  has_many :equipment_models, -> { order(:order, :name) }, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :order, numericality: { only_integer: true }, presence: true

  scope :with_equipment_models, -> () { order(:order, :name).includes(:equipment_models) }
end
