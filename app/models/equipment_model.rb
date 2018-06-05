include ActionView::Helpers::NumberHelper

class EquipmentModel < ApplicationRecord

  belongs_to :equipment_group

  has_many :equipment_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :order, numericality: { only_integer: true }, presence: true

  mount_uploader :photo, PhotoUploader

  def price_str
    number_to_currency(self.price)
  end
end
