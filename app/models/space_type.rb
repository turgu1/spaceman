class SpaceType < ApplicationRecord
  has_many :spaces, dependent: :nullify, inverse_of: :space_type
  has_many :equipment_items, as: :itemable, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :equipment_items, allow_destroy: true

  default_scope { order(:name) }
  
  scope :with_spaces, -> (ids) { where(id: ids).order(:name).includes(spaces: :floor) }

  # Build a floors array pertaining to the space_type associated to spaces. 
  #
  def associated_floors
    Floor.with_spaces_of_space_type(self.id)
  end

end
