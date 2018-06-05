class Space < ApplicationRecord
  belongs_to :floor, touch: true
  belongs_to :space_type,  inverse_of: :spaces, counter_cache: true, optional: true

  has_many :allocations, inverse_of: :space,  dependent: :destroy
  has_many :equipment_items, as: :itemable, dependent: :destroy

  validates :name, :coor, :figure, :floor_id, presence: true
  validates :name,        uniqueness: { scope: :floor_id }
  validate  :validate_space

  accepts_nested_attributes_for :equipment_items, allow_destroy: true

  after_validation :generate_complementary_values

  scope :with_allocations, -> (id) {
    where(id: id).includes([
      {floor: :building},
      {allocations: [:consumer, {equipment_items: :equipment_model}]},
      {space_type: {equipment_items: :equipment_model}},
      {equipment_items: :equipment_model}])
  }

  scope :with_allocs, -> {
    includes([
      {floor: :building},
      {allocations: [:consumer, {equipment_items: :equipment_model}]},
      {space_type: {equipment_items: :equipment_model}},
      {equipment_items: :equipment_model}])
  }

  def floor_name
    self.floor.name
  end

  def complete_name
    "#{self.floor.complete_name} / #{self.name}"
  end

  def complete_short_name
    "#{self.floor.complete_short_name} / #{self.name}"
  end

  def space_type_name
    str = self.space_type.try(:name)
    str ||= ""
  end

  def allocate_equipment?
    @my_alloc_equip ||= self.floor.building.allocate_equipment?
  end

  def moving_items?
    @my_mov_items ||= self.floor.building.moving_items?
  end

  def all_moving_items
    all = []
    self.allocations.each do |a|
      all += a.moving_items
    end
    all
  end

  def generate_complementary_values
    return false unless self.errors.empty?
    unless self.coor.blank?
      c = self.coor.split(',').map { |i| i.to_i }

      # Insure that figure type is appropriate for the number of coordinates
      self.figure = 'P' if c.size > 4
      self.figure = 'R' if c.size == 4

      if self.figure == 'R'

        self.coor = sort_rectangle_coordinates(c).join(',')

        # Find the center coordinates of the rectangle
        self.center_coor = rectangle_center(c)
      else
        # Find the center coordinates of the polygon
        self.center_coor = polygon_center(c)
      end

      # If the space area has not been entered, try to compute it
      # using the reference area setup in the floor caracteristics.
      self.area = compute_area if self.area.nil? || (self.area < 1)
    end
  end

private

  def validate_space

    # Vérification de la validité des coordonnées reçues dans le champ "coor"
    def validate_coordinates?
      if self.coor.blank?
        false
      else
        c = coor.split(',')
        if c.size.odd? or ((figure == 'P') and (c.size < 6)) then
          return false
        else
          c.each do |x|
            if x != (x.to_i.to_s) then
              return false
            end
          end
        end
        true
      end
    end

    errors.add(:figure, I18n.t('space.invalid_figure_type')) unless (figure == 'R') or (figure == 'P')
    errors.add(:coor, I18n.t('space.invalid_coordinates')) unless validate_coordinates?
  end

  # Calcul de la position centrale d'un rectangle
  def rectangle_center(c)
    x = ((c[2] - c[0]) / 2).to_i
    y = ((c[3] - c[1]) / 2).to_i
    [x + c[0], y + c[1]].join(',')
  end

  # Calcul de la position centrale d'un polygone
  def polygon_center(c)
    c << c[0]
    c << c[1]

    a = 0
    0.step(c.size - 4, 2) do |i|
      a += (((c[i + 2] - c[i]) * (c[i + 3] + c[i + 1])) / 2)
    end
    a = a.abs

    x = 0
    y = 0
    0.step(c.size - 4, 2) do |i|
      tmp = (c[i] * c[i + 3]) - (c[i + 2] * c[i + 1])
      x += (c[i] + c[i + 2]) * tmp
      y += (c[i + 1] + c[i + 3]) * tmp
    end
    x = ((x / 6) / a).to_i
    y = ((y / 6) / a).to_i
    if x < 0
      x = -x
      y = -y
    end
    [x, y].join(',')
  end

  # Sort the coordinates to obtain [left, top, right, bottom]
  def sort_rectangle_coordinates(c)
    if c[0] > c[2]
      t = c[2]
      c[2] = c[0]
      c[0] = t
    end
    if c[1] > c[3]
      t = c[3]
      c[3] = c[1]
      c[1] = t
    end
    c
  end

  def compute_area
    unless self.floor.gage_area.nil?
      ref = self.floor.gage_coor.split(',').map { |i| i.to_i }
      ref_pixel_area = (ref[2] - ref[0]) * (ref[3] - ref[1])
      c = self.coor.split(',').map { |i| i.to_i }
      if self.figure == 'R'
        my_pixel_area = (c[2] - c[0]) * (c[3] - c[1])
      else
        c << c[0]
        c << c[1]
        my_pixel_area = 0
        0.step(c.size - 4, 2) do |i|
          my_pixel_area += (((c[i+2] - c[i]) * (c[i+3] + c[i+1])) / 2)
        end
        my_pixel_area = my_pixel_area.abs # / 2
      end
      sprintf("%8.1f",(my_pixel_area.to_f * self.floor.gage_area) / ref_pixel_area.to_f).to_f
    end
  end
end
