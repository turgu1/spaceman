
module BuildingsHelper

  def cache_key_for_buildings
    count          = Building.count
    max_updated_at = Building.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "buildings/all-#{count}-#{max_updated_at}"
  end

  # Build a hash of the building levels information to prepare the level drawings
  # on the sidebar. The data is supplied back as follow:
  #
  # [ [level, {floor_id => [locator_coor], ...} ...]
  #
  def levels_locations(building)
    data = {}
    levs = []
    level = building.min_level || 0
    Floor.where(building_id: building.id).order(:level).each do |floor|
      while level < floor.level
        levs << [level, data]
        data = {}
        level += 1
      end
      data[floor.id] = floor.locator_coor unless floor.locator_coor.blank?
    end
    clevel = level
    while level <= (building.max_level || clevel)
      levs << [level, data]
      data = {}
      level += 1
    end
    levs
  end
end
