class Requirement < ApplicationRecord
  belongs_to :org, inverse_of: :requirements
  belongs_to :person, foreign_key: :requester_id, optional: true
  has_many :allocations, as: :consumer, dependent: :destroy

  validates :org_id, :from_date, :project_name, presence: true

  scope :with_allocations, -> (id) { where(id: id).includes(allocations: {space: [:space_type, {floor: :building}]}) }

  after_save :touch_allocations

  def name
    "[ #{self.project_name} ]"
  end

  def short_name
    w = self.project_name.split(' ')
    if w.size == 1
      w[0][0..5]
    else
      "#{w[0][0..0]}." + w[1..-1].each.map { |s| s[0..5] }.join('.')
    end
  end

  def org_name
    org.name
  end

  def requester_name
    person.nil? ? 'None' : person.name
  end

  # Build a floors array pertaining to the requirement allocations
  #
  def allocation_floors
    Floor.with_allocations_to_requirement(self.id)
  end

  def touch_allocations
    allocations.each { |a| a.touch }
  end

end
