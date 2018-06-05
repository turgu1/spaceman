require 'rails_helper'

RSpec.describe Floor, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:level) }
  it { is_expected.to validate_presence_of(:drawing) }
  it { is_expected.to validate_presence_of(:building_id) }

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:wing_id) }

  it { is_expected.to validate_numericality_of(:gage_area).allow_nil }
  it { is_expected.to validate_numericality_of(:order).only_integer }
  it { is_expected.to validate_numericality_of(:level) }

  it { is_expected.to belong_to(:building).inverse_of(:floors) }
  it { is_expected.to belong_to(:wing).counter_cache(true) }

  it { is_expected.to have_many(:spaces).inverse_of(:floor).dependent(:destroy) }

  # it { is_expected.to }
end
