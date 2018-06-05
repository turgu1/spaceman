class Person < ApplicationRecord
  belongs_to :org, inverse_of: :people
  
  has_many :allocations, as: :consumer, dependent: :destroy
  has_many :requirements, foreign_key: :requester_id, dependent: :nullify

  has_many :orgs_as_manager, class_name: 'Org', foreign_key: :manager_id, dependent: :nullify
  has_many :orgs_as_admin, class_name: 'Org', foreign_key: :admin_id,   dependent: :nullify

  validates :org_id, :last_name, :first_name, :from_date, presence: true
  # validates :last_name, :first_name, uniqueness: { scope: :org_id }

  scope :in_org, -> (org_id) { where(org_id: org_id).order(last_name: :asc, first_name: :asc) }
  scope :with_allocations, -> (id) { where(id: id).includes(allocations: {space: [:space_type, {floor: :building}]}) }

  after_save :touch_allocations

  def name
    "#{last_name}, #{first_name}"
  end

  def small_name
    @small_name ||= "#{last_name}, #{first_name[0].split('-').map { |s| s[0..0]+'.' }.join('-')}"
  end

  def short_name
    "#{first_name[0]}.#{last_name[0..3]}"
  end
  
  def org_name
    org.name
  end

  # Build a floors array pertaining to the person allocations. 
  #
  def allocation_floors
    Floor.with_allocations_to_person(self.id)
    # floors = []
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

  def touch_allocations
    allocations.each { |a| a.touch }
  end
end
