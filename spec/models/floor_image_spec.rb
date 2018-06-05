require 'rails_helper'

RSpec.describe FloorImage, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:level) }
  it { is_expected.to validate_presence_of(:file) }

  it { is_expected.to belong_to(:building).inverse_of(:floor_images) }

  # it { is_expected.to }
end
