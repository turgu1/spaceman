class FloorImage < ApplicationRecord
  belongs_to :building, inverse_of: :floor_images

  validates :level, :name, :file, presence: true

  scope :related_to_floor, -> (floor) { where(building_id: floor.building_id, level: floor.level) }

  mount_uploader :file, FloorImageUploader
end
