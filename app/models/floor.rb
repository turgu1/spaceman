require 'rubygems'
#require 'RMagick'

class Floor < ApplicationRecord
  
  belongs_to :building, inverse_of: :floors
  belongs_to :wing, counter_cache: true

  has_many :spaces, inverse_of: :floor, dependent: :destroy

  validates :building_id, :name, :level, :drawing, presence: true
  validates :name,        uniqueness: { scope: :wing_id }
  validates :gage_area,   numericality: true, allow_nil: true
  validates :order,       numericality: { only_integer: true }
  validates :level,       numericality: { only_integer: true }

  validate :validate_floor

  scope :with_allocations, -> (id) {
      where(id: id).includes([{spaces: [{allocations: [{person: :org}, {requirement: :org}]}, :space_type]}, :building, :wing])
      .order('spaces.name')
      .references(:spaces)
  }

  scope :with_spaces, -> (id) {
    where(id: id).includes([{spaces: :space_type}, :building, :wing])
      .order('spaces.name')
      .references(:spaces)
  }

  scope :with_spaces_of_space_type, -> (space_type_id) {
    includes(:spaces, :building)
      .where('spaces.space_type_id = ?', space_type_id)
      .order('buildings.name, floors.order, floors.name, spaces.name')
      .references(:spaces, :buildings)
  }

  scope :with_allocations_to_org, -> (org_id) {
      includes({spaces: [{allocations: [{person: :org}, {requirement: :org}]}, :space_type]}, :building, :wing)
      .where('people.org_id = ? OR requirements.org_id = ?', org_id, org_id)
      .order('buildings.name, floors.order, floors.name, spaces.name')
      .references(:buildings, :spaces, :allocations, :people, :requirements)
  } 

  scope :with_allocations_to_person, -> (person_id) {
      includes({spaces: [{allocations: [{person: :org}]}, :space_type]}, :building, :wing)
      .where('people.id = ?', person_id)
      .order('buildings.name, floors.order, floors.name, spaces.name')
      .references(:buildings, :spaces, :allocations, :people)
  } 

  scope :with_allocations_to_requirement, -> (requirement_id) {
      includes({spaces: [{allocations: [requirement: :org]}, :space_type]}, :building, :wing)
      .where('requirements.id = ?', requirement_id)
      .order('buildings.name, floors.order, floors.name, spaces.name')
      .references(:buildings, :spaces, :allocations, :requirements)
  } 

  before_update :update_corners_coor
  before_save :adjust_gage

  mount_uploader :drawing, DrawingUploader

  def apply_transformation
    @apply_transfo ||= false
  end

  def apply_transformation=(value)
    @apply_transfo = (value == '1')
  end

  def complete_name
    if self.wing
      "#{self.wing.complete_name} / #{self.name}"
    else
      "#{self.building.name} / #{self.name}"
    end
  end

  def complete_short_name
    if self.wing
      "#{self.wing.complete_short_name} / #{self.name}"
    else
      "#{self.building.short_name} / #{self.name}"
    end
  end

  # Returns the drawing of the floor with all spaces drawn on it. The
  # spaces will be painted red if some allocation have been made,
  # green otherwise (free space). The name of the space will be
  # written in the center.
  def drawing_with_all_allocations

    image = image_setup
    gc = drawing_setup

    # Display-list generation for the identified spaces
    self.spaces.each do |space|

      no_allocs = space.allocations.nil? || space.allocations.size == 0

      gc.stroke('white').fill('white')
      draw_figure(gc, space, 0.8, 0.8)

      if space.space_type.nil?
        gc.stroke('gold3').fill('gold2')
      elsif no_allocs
        gc.stroke('green').fill('lightgreen')
      else
        gc.stroke('red').fill('red')
      end

      draw_figure(gc, space)

      gc.fill(no_allocs ? 'green' : 'red') # if no_allocs

      draw_text(gc, space)
    end
    gc.draw(image)

    image.to_blob
  end

  # Returns the drawing of the floor with all spaces allocated to a requirement
  # drawn on it. The spaces will be painted red,
  # with the name of the space written in the center.
  def drawing_with_allocations

    image = image_setup
    gc = drawing_setup

    spaces.each do |space|

      gc.stroke('white').fill('white')
      draw_figure(gc, space, 0.8, 0.8)

      if space.space_type.nil?
        gc.stroke('gold3').fill('gold2')
      else
        gc.stroke('red').fill('red')
      end

      draw_figure(gc, space)

      gc.fill(space.space_type.nil? ? 'gold2' : 'red')

      draw_text(gc, space)
    end
    gc.draw(image)

    image.to_blob
  end

  # Reproduces the floor drawing with the gage area (if coordinates has been entered).
  # The result is sent back as an image.
  def drawing_with_gage_area

    image = image_setup

    # Display-list generation for the gage area

    gc = drawing_setup

    unless self.gage_coor.length == 0

      gc.stroke('green').fill('lightgreen')
      gc.stroke_opacity(0.7).fill_opacity(0.3)
      gc.rectangle(*self.gage_coor.split(','))

      unless self.gage_area.nil?
        gc.fill('green')
        xy = self.gage_center_coor.split(',').map { |i| i.to_i }
        gc.opacity(1).stroke('none')
        gc.text(xy[0], xy[1], "'#{self.gage_area} m²'")
      end

    end

    draw_corners(gc)

    gc.draw(image)

    image.to_blob

  end

  def drawing_locator

    image = image_setup(FloorImage.related_to_floor(self).take.try(:file).try(:path))

    return nil if image.nil?

    gc = drawing_setup

    unless self.locator_coor.nil?
      unless self.locator_coor.length == 0
        gc.stroke('green').fill('lightgreen')
        gc.stroke_opacity(0.7).fill_opacity(0.3)
        coor = self.locator_coor.split(',')
        if coor.size == 4
          gc.rectangle(*coor)
        else
          gc.polygon(*coor)
        end
      end
    end

    gc.draw(image)
    image.to_blob
  end

  def all_allocations
    allocs = []
    spaces.each do |s|
      allocs += s.allocations
    end
    allocs.sort! { |x,y| x.space.name <=> y.space.name }
    allocs
  end

  def adjust_coord_bulk(spaces, type)

    # Retrieve all space coordinates
    coords = []
    spcs = Space.find(spaces.map { |id| id.to_i })
    spcs.each { |s| return false if s.figure != 'R' }
    spcs.each do |s|
      coords << s.coor.split(',').map { |c| c.to_i }
    end

    case type
      when :all
        (0..3).each do |i|                   # For each coordinates: x0 y0 x1 y1
          (0..(coords.size - 2)).each do |j| # For each space but last
            val = coords[j][i]               # Get coor value and compute range to align
            min, max = val - 5, val + 5
            ((j + 1)..(coords.size - 1)).each do |jj| # Do adjustment for the remaining spaces
              coords[jj][i] = val if coords[jj][i].between?(min, max) # Adjust sides
              if i < 2                                                # Adjust overlaping edges
                coords[jj][i+2] = val if coords[jj][i+2].between?(min, max)
              else
                coords[jj][i-2] = val if coords[jj][i-2].between?(min, max)
              end
            end
          end
        end
      when :horizontal
        [1,3].each do |i|                     # For each coordinates: y0 y1
          (0..(coords.size - 2)).each do |j|  # For each space but last
            val = coords[j][i]                # Get coor value and compute range to align
            min, max = val - 5, val + 5
            ((j + 1)..(coords.size - 1)).each do |jj| # Do adjustment for the remaining spaces
              coords[jj][i] = val if coords[jj][i].between?(min, max) # Adjust sides
            end
          end
        end
      when :vertical
        [0,2].each do |i|                     # For each coordinates: y0 y1
          (0..(coords.size - 2)).each do |j|  # For each space but last
            val = coords[j][i]                # Get coor value and compute range to align
            min, max = val - 5, val + 5
            ((j + 1)..(coords.size - 1)).each do |jj| # Do adjustment for the remaining spaces
              coords[jj][i] = val if coords[jj][i].between?(min, max) # Adjust sides
            end
          end
        end
    end

    (0..(coords.size - 1)).each do |i|
      spcs[i].coor = coords[i].join(',')
      spcs[i].save
    end

    true
  end

  def set_space_type_bulk(spaces, space_type_id)
    spaces.each do |space_id|
      Space.find(space_id.to_i).update(space_type_id: space_type_id)
    end
  end

  def self.import(struct, wing = nil)
    res = []
    unless wing
      building = begin
        Building.find_by!(name: struct[:building][:name])
      rescue
        return([I18n.t('floor.building_not_found', item: struct[:building][:name])])
      end
      struct.delete(:building)
      wing = begin
        building.wings.find_by!(name: struct[:wing][:name])
      rescue
        return([I18n.t('floor.wing_not_found', item: struct[:wing][:name])])
      end
      struct.delete(:wing)
    end
    floor = wing.floors.find_by(name: struct[:name])
    spaces = struct.delete(:spaces)
    unless floor
      begin
        wing.floors << Floor.new(struct)
      rescue
        return([I18n.t('floor.unable_to_create_floor', item: struct[:name])])
      end
      res << I18n.t('floor.floor_created', item: struct[:name])
    end

    spaces.each do |space_data|
      space_data.deep_symbolize_keys!
      space = floor.spaces.find_by(name: space_data[:name])
      unless space
        space_type = space_data.delete(:space_type)
        begin
          space = Space.new(space_data)
          floor.spaces << space
        rescue
          res << I18n.t('floor.unable_to_create_space', item: space_data[:name])
        end
        if space_type[:name]
          space.space_type = SpaceType.find_or_create_by(name: space_type[:name])
          space.save
        end
        res << I18n.t('floor.space_created', item: space.name)
      end
    end

    res << ''
    res << I18n.t('floor.floor_import_completed', item: struct[:name])
  end

  private

    def validate_floor
      errors.add(:gage_coor, I18n.t('floor.rectangle_corners')) unless valid_gage_coor
      errors.add(:locator_coor, I18n.t('floor.locator_coor_not_valid')) unless valid_locator_coor
      errors.add(:corners_coor, I18n.t('floor.corners_coor_not_valid')) unless valid_corners_coor
      errors.add(
        :gage_area, I18n.t('floor.gage_coordinates_and_area')
      ) unless (
        ((self.gage_coor.nil? or (self.gage_coor.length == 0)) and self.gage_area.nil?) or 
        (((not self.gage_coor.nil?) and (self.gage_coor.length > 0)) and not self.gage_area.nil?)
      )

      errors.add(
        :level,
        I18n.t('floor.must_be_in_range', from: self.building.min_level, to: self.building.max_level)
      ) unless self.building.nil? or self.level.between?(self.building.min_level, self.building.max_level)
    end

    def valid_locator_coor
      unless self.locator_coor.nil? or (self.locator_coor.length == 0)
        c = self.locator_coor.split(',')
        if c.size.odd? or (c.size < 4) then
          return false
        end
      end
      true
    end

    def valid_corners_coor
      unless self.corners_coor.nil? or (self.corners_coor.length == 0)
        c = self.corners_coor.split(',')
        if c.size != 4 then
          return false
        end
      end
      true
    end

    def valid_gage_coor
      if (not self.gage_coor.nil?) and (self.gage_coor.length > 0)
        c = self.gage_coor.split(',')
        if c.size != 4 then
          return false
        else
          c.each do |x|
            if x != (x.to_i.to_s)
              return false
            end
          end
        end
      end
      true
    end

    def rectangle_center(c)
      x = ((c[2] - c[0]) / 2).to_i
      y = ((c[3] - c[1]) / 2).to_i
      [x+c[0], y+c[1]].join(',')
    end

    def image_setup(image = self.drawing.path)
      unless image.nil?
        Magick::ImageList.new.read(image)
      end
    end

    def drawing_setup
      gc = Magick::Draw.new
      gc.font_family('arial')
      gc.gravity(Magick::CenterGravity)
      gc.pointsize(12)
      gc.font_style(Magick::NormalStyle)
      gc.text_align(Magick::CenterAlign)
      gc.font_weight(Magick::BoldWeight)
      gc.stroke_width(1)
      gc
    end

    def draw_figure(gc, space, stroke = 0.7, fill = 0.3)
      gc.stroke_opacity(stroke).fill_opacity(fill)
      coor = space.coor.split(',')
      if (space.figure == 'R') && (coor.size == 4)
        gc.rectangle(*coor)
      else
        gc.polygon(*coor)
      end
    end


    def draw_text_lines(gc, lines, space)
      xy = space.center_coor.split(',').map { |i| i.to_i }
      x = []
      y = []
      space.coor.split(',').map { |i| i.to_i }.each_with_index { |v,i| (i.odd? ? y : x) << v }
      top_y, bottom_y, center_x = y.min, y.max, xy[0] 
      max_lines = (bottom_y - top_y) / 12
      line_count = [lines.length, max_lines].min

      x = center_x
      y = top_y + (((bottom_y - top_y) - (line_count * 12)) / 2) + 12

      gc.fill('gold4') if space.space_type.nil?
      gc.opacity(1).stroke('none')

      (0..(line_count - 1)).each do |i|
        gc.text(x, y, lines[i]) unless lines[i].blank?
        y += 12
      end
    end

    def draw_text(gc, space)

      lines = []

      lines << "#{space.name || ''}#{space.space_type.nil? ? '?' : ''}"  # name

      if space.allocations.length > 0
        space.allocations.each { |a| lines << a.consumer_short_name[0..6] }
      else
        if !space.function.blank?
          lines << space.function
        elsif !space.space_type.nil?
          lines << space.space_type.short_name
        end
      end
      draw_text_lines gc, lines, space
    end

    def draw_cross(gc, x, y)
      gc.line(x-10, y, x+10, y)
      gc.line(x, y-10, x, y+10)
    end

    def draw_corners(gc)
      unless corners_coor.blank?
        xy =  corners_coor.split(',').map { |i| i.to_i }
        if xy.size == 4
          gc.stroke('red').stroke_width(1).stroke_opacity(1.0)
          draw_cross(gc, xy[0], xy[1])
          draw_cross(gc, xy[2], xy[3])
        end
      end
    end

    def update_corners_coor

      def apply_transform(coor)
        c = coor.split(',').map { |i| i.to_i }
        i = 0
        while i < c.size
          c[i] = ((c[i] * @scale_x) + @shift_x).round
          c[i+1] = ((c[i+1] * @scale_y) + @shift_y).round
          i += 2
        end
        c.join(',')
      end

      if apply_transformation && corners_coor_changed?
        old =  corners_coor_was.split(',').map { |i| i.to_i }
        new =  corners_coor.split(',').map { |i| i.to_i }

        return if (old.size != 4) || (new.size != 4)

        @scale_x = (new[2] - new[0]) / (old[2] - old[0]).to_f
        @scale_y = (new[3] - new[1]) / (old[3] - old[1]).to_f
        @shift_x = new[0] - (old[0] * @scale_x)
        @shift_y = new[1] - (old[1] * @scale_y)

        # puts("=====> FLOOR CORNERS UPDATE! FACTORS: [#{@shift_x}, #{@shift_y}] - [#{@scale_x}, #{@scale_y}]")

        self.spaces.each do |sp|
          sp.coor = apply_transform(sp.coor)
          sp.center_coor = apply_transform(sp.center_coor)
          sp.save
        end

        self.gage_coor = apply_transform(self.gage_coor)
        self.gage_center_coor = apply_transform(self.gage_center_coor)

      end
    end

    def adjust_gage
      unless self.gage_coor.nil? || (self.gage_coor.length == 0)
        c = self.gage_coor.split(',').map { |i| i.to_i }

        # On rectifie l'ordre des  coordonnées du rectangle afin
        # d'obtenir [left, top, right, bottom]
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
        self.gage_coor = c.join(',')

        # On trouve les coordonnées du centre du rectangle
        self.gage_center_coor = rectangle_center(c)
      end
    end

end
