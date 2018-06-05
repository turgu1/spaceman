class TableDef < ApplicationRecord
  has_many :fields, -> { order(:order) }, class_name: 'FieldDef', dependent: :destroy

  validates :name, presence: true

  default_scope { includes(:fields) }
  
  accepts_nested_attributes_for :fields, allow_destroy: true
end
