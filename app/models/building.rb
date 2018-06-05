class Building < ApplicationRecord

  has_many :floors,       -> { order(:order, :name) },        inverse_of: :building, dependent: :destroy
  has_many :wings,        -> { order(:order, :name) }, inverse_of: :building, dependent: :destroy
  has_many :floor_images, -> { order(:level) },        inverse_of: :building, dependent: :destroy

  validates :name,  :short_name, presence: true, uniqueness: true
  validates :photo, :min_level, :max_level, presence: true
  validates :min_level, :max_level, :numericality => true

  default_scope { order(:name) }

  scope :with_floors,      -> () { includes({wings: :floors}) }
  scope :with_allocations, -> (id) {
    where(id: id).includes({wings: {floors:
      [{spaces: [{allocations: [{person: :org}, {requirement: :org}]}, :space_type]}, :building, :wing] 
    }})
  }
  scope :with_spaces, -> (id) {
    where(id: id).includes({wings: {floors: {spaces: [:space_type]}}})
  }

  mount_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :floor_images, allow_destroy: true
end
