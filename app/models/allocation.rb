class Allocation < ApplicationRecord
  belongs_to :space, inverse_of: :allocations, touch: true
  #belongs_to :user
  belongs_to :consumer, counter_cache: true, polymorphic: true
  belongs_to :person,      
    -> { where(allocations: { consumer_type: 'Person' }).includes(:allocations) }, 
    foreign_key: :consumer_id, 
    optional: true
  belongs_to :requirement, 
    -> { where(allocations: { consumer_type: 'Requirement' }).includes(:allocations) }, 
    foreign_key: :consumer_id, 
    optional: true
  has_one :org, through: :consumer

  #belongs_to :person, inverse_of: :allocations
  #belongs_to :requirement, inverse_of: :allocations

  has_many :equipment_items, as: :itemable, dependent: :destroy
  has_many :moving_items, inverse_of: :allocation, dependent: :destroy

  validates :space_id, :from_date, :consumer_id, :consumer_type, presence: true

  accepts_nested_attributes_for :equipment_items, allow_destroy: true
  accepts_nested_attributes_for :moving_items, allow_destroy: true

  validate :validate_dates

  # In support of the simple_form for allocations
  def person_id
    self.consumer_type == 'Person' ? self.consumer_id : nil
  end

  def requirement_id
    self.consumer_type == 'Requirement' ? self.consumer_id : nil
  end

  def name
    space.nil? ? 'nil' : space.name
  end

  # The following methods will supply fields pertaining to consumers, using
  # eager loaded entities instead of the :consumer property
  def consumer_name
    if self.consumer_type == 'Person' 
      self.person.name
    else
      self.requirement.name
    end
  end

  def consumer_short_name
    if self.consumer_type == 'Person' 
      self.person.short_name
    else
      self.requirement.short_name
    end
  end

  def consumer_org_name
    if self.consumer_type == 'Person' 
      self.person.org.abbreviation
    else
      self.requirement.org.abbreviation
    end
  end

  def target
    consumer.nil? ? 'none' : consumer_name
  end

  def short_name
    "#{space.floor.building.short_name} / #{space.name}"
  end

  def allocate_equipment?
    @my_alloc_equip ||= self.space.floor.building.allocate_equipment?
  end

  def moving_items?
    @my_mov_items ||= self.space.floor.building.moving_items?
  end

private

  def validate_dates
    unless from_date.nil?
      if !(to_date.nil? || from_date.nil?) && (from_date > to_date)
        errors.add(:from_date, I18n.t('allocation.from_smaller_than_two'))
      end

      #if person.nil?
      #  if requirement.nil?
      #    errors.add(:person, "A Person or a Requirement must be supplied")
      #  else
      #    if (from_date < requirement.from_date) || (!(requirement.to_date.nil? || to_date.nil?) && (to_date > requirement.to_date))
      #      errors.add(:to_date, "Dates must be inside the Requirement date interval.")
      #    end
      #  end
      #else
      #  errors.add(:requirement, "A Person or a Requirement must be supplied. Not both.") unless requirement.nil?
      #  if (from_date < person.from_date) || (!(person.to_date.nil? || to_date.nil?) && (to_date > person.to_date))
      #    errors.add(:to_date, "Dates must be inside the Person date interval.")
      #  end
      #end
    end
  end

end
