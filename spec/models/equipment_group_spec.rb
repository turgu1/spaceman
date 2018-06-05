require 'rails_helper'

RSpec.describe EquipmentGroup, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to belong_to(:equipment_group).with_foreign_key(:parent) }

  it { is_expected.to have_many(:equipment_models).order([:order, :name]).dependent(:destroy) }

  # it { is_expected.to }
end
