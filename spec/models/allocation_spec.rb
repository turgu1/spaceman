require 'rails_helper'

RSpec.describe Allocation, type: :model do

  it { is_expected.to validate_presence_of(:space_id) }
  it { is_expected.to validate_presence_of(:from_date) }
  it { is_expected.to validate_presence_of(:consumer_id) }
  it { is_expected.to validate_presence_of(:consumer_type) }

  it { is_expected.to accept_nested_attributes_for(:equipment_items).allow_destroy(true) }
  it { is_expected.to accept_nested_attributes_for(:moving_items).allow_destroy(true) }

  it { is_expected.to belong_to(:space).inverse_of(:allocations).touch(true) }
  it { is_expected.to belong_to(:consumer).counter_cache(true) }
  it { is_expected.to belong_to(:person).with_foreign_key(:consumer_id).conditions(allocations: { consumer_type: 'Person'}) }
  it { is_expected.to belong_to(:requirement).with_foreign_key(:consumer_id).conditions(allocations: { consumer_type: 'Requirement'}) }

  # it { is_expected.to have_one(:org).through(:consumer) }

  it { is_expected.to have_many(:equipment_items).dependent(:destroy) }
  it { is_expected.to have_many(:moving_items).inverse_of(:allocation).dependent(:destroy) }

  # it { is_expected.to }
end
