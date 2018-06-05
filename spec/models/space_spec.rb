require 'rails_helper'

RSpec.describe Space, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:coor) }
  it { is_expected.to validate_presence_of(:figure) }
  it { is_expected.to validate_presence_of(:floor_id) }

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:floor_id) }

  it { is_expected.to accept_nested_attributes_for(:equipment_items).allow_destroy(true) }

  it { is_expected.to belong_to(:floor).touch(true) }
  it { is_expected.to belong_to(:space_type).inverse_of(:spaces).counter_cache(true) }

  it { is_expected.to have_many(:allocations).inverse_of(:space).dependent(:destroy) }
  it { is_expected.to have_many(:equipment_items).dependent(:destroy) }

  # it { is_expected.to }
end
