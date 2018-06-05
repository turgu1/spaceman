require 'rails_helper'

RSpec.describe Building, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:short_name) }
  it { is_expected.to validate_presence_of(:photo) }
  it { is_expected.to validate_presence_of(:min_level) }
  it { is_expected.to validate_presence_of(:max_level) }

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_uniqueness_of(:short_name) }

  it { is_expected.to accept_nested_attributes_for(:floor_images).allow_destroy(true) }

  it { is_expected.to have_many(:floors).order([:order, :name]).inverse_of(:building).dependent(:destroy) }
  it { is_expected.to have_many(:wings ).order([:order, :name]).inverse_of(:building).dependent(:destroy) }
  it { is_expected.to have_many(:floor_images).order(:level).inverse_of(:building).dependent(:destroy) }

  # it { is_expected.to }
end
