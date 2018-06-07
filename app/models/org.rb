class Org < ApplicationRecord
  
  belongs_to :manager, class_name: 'Person', foreign_key: :manager_id, optional: true
  belongs_to :admin,   class_name: 'Person', foreign_key: :admin_id, optional: true
  has_many :people,       -> { order(:last_name, :first_name) }, dependent: :destroy
  has_many :requirements, -> { order(:project_name) }, dependent: :destroy

  validates :name, :abbreviation, :order, presence: true
  validates :name, :abbreviation, uniqueness: true
  validates :order, numericality: { only_integer: true }

  default_scope { order(:order, :abbreviation) }

  scope :people_and_requirements, -> () { 
    includes([:people, :requirements]) 
  }

  scope :with_people, -> (id) { where(id: id).includes(:people) }
  scope :with_people_and_requirements, -> (id) { 
    where(id: id).includes([:people, :requirements]) 
  }
  scope :with_allocations, -> (id) {
    where(id: id).includes([
      {people: {allocations: [:consumer, {space: [:space_type, {floor: :building}]}]}},
      {requirements: {allocations: [:consumer, {space: [:space_type, {floor: :building}]}]}}])
  }
  scope :with_allocations_only, -> (id) {
    where(id: id).includes([
       {people: :allocations},
       {requirements: :allocations}])
  }

  accepts_nested_attributes_for :people,       allow_destroy: true
  accepts_nested_attributes_for :requirements, allow_destroy: true

  def manager_name
    manager.nil? ? '' : manager.name
  end

  def admin_name
    admin.nil? ? '' : admin.name
  end

  def self.get(the_org)
    unless defined?(the_org)
      nil
    else
      if the_org.class == self
        the_org
      else
        self.with_people(the_org).take #self.find the_org, include: :people
      end
    end
  end

  def add_allocation(alloc)
    @allocs ||= []
    @allocs << alloc
  end

  def allocations
    if @allocs.nil?
      @allocs = []
      self.people.each do |person|
        @allocs += person.allocations
      end
      self.requirements.each do |req|
        @allocs += req.allocations
      end
    end
    @allocs
  end

  # Build a floors array pertaining to the org allocations. Each entry contains:
  #
  # { floor: floor, allocations: [allocs] }
  #
  def allocation_floors
    Floor.with_allocations_to_org(self.id)
    # floors = []
    # self.allocations.sort! { |x,y| x.space.name <=> y.space.name }
    # self.allocations.each do |alloc|
    #   idx = floors.find_index { |f| f[:floor].id == alloc.space.floor_id }
    #   floors << {floor: alloc.space.floor, allocations: []} unless idx
    #   idx ||= floors.size - 1
    #   floors[idx][:allocations] << alloc
    # end
    # sorted_floors = []
    # Building.all.with_floors.each do |building|
    #   building.wings.each do |wing|
    #     wing.floors.each do |floor|
    #       idx = floors.find_index { |f| f[:floor].id == floor.id }
    #       sorted_floors << floors[idx] if idx
    #     end
    #   end
    # end
    # sorted_floors
  end

end
