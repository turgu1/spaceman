require 'rails_helper'

RSpec.describe MovingItem, type: :model do

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:qty) }
  it { is_expected.to validate_presence_of(:allocation_id) }

  it { is_expected.to validate_numericality_of(:qty).only_integer.is_greater_than_or_equal_to(1) }
  it { is_expected.to validate_numericality_of(:weight).is_greater_than(0).allow_nil }
  it { is_expected.to validate_numericality_of(:volume).is_greater_than(0).allow_nil }

  it { is_expected.to accept_nested_attributes_for(:moving_tasks).allow_destroy(true) }

  it { is_expected.to belong_to(:allocation).inverse_of(:moving_items) }
  it { is_expected.to belong_to(:destination).class_name('Allocation') }
  it { is_expected.to belong_to(:replace).class_name('EquipmentItem') }

  # it { is_expected.to }
end
