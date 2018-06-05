require 'rails_helper'

RSpec.describe EquipmentItem, type: :model do

  it { is_expected.to validate_presence_of(:equipment_model_id) }

  it { is_expected.to validate_numericality_of(:qty).only_integer.is_greater_than_or_equal_to(1) }

  it { is_expected.to belong_to(:itemable) }
  it { is_expected.to belong_to(:equipment_model) }

end
