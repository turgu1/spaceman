class FieldDef < ApplicationRecord
  belongs_to :table_def

  validates :name, :order, presence: true
  validates :order, numericality: { only_integer: true }
end
