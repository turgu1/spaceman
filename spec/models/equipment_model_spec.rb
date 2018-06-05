require 'rails_helper'

RSpec.describe EquipmentModel, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0).allow_nil }

  it { is_expected.to belong_to(:equipment_group) }

  it { is_expected.to have_many(:equipment_items).dependent(:destroy) }

  # it { is_expected.to }
end
