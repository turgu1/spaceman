require 'rails_helper'

RSpec.describe Wing, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:short_name) }
  it { is_expected.to validate_presence_of(:building_id) }

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:building_id) }

  it { is_expected.to belong_to(:building).inverse_of(:wings) }

  it { is_expected.to have_many(:floors).order([:order, :name]).inverse_of(:wing).dependent(:nullify) }

  # it { is_expected.to }

  describe "returns a composed complete name" do

    it "with the building name at front of the wing name, if the wing visible" do

      bldg = build_stubbed(:building, name: "The Building")
      wing = build_stubbed(:wing, name: "The Wing", building: bldg)

      expect(wing.complete_name).to eq("The Building / The Wing")
    end

    it "with only the building name, if the wing is not visible" do

      bldg = build_stubbed(:building, name: "The Building")
      wing = build_stubbed(:wing, name: "The Wing", visible: false, building: bldg)

      expect(wing.complete_name).to eq("The Building")
    end

  end

  describe "returns a composed complete short name" do

    it "with the building short name at front of the wing short name, if the wing visible" do

      bldg = build_stubbed(:building, short_name: "101")
      wing = build_stubbed(:wing, short_name: "1", building: bldg)

      expect(wing.complete_short_name).to eq("101 / 1")
    end

    it "with only the building short name, if the wing is not visible" do

      bldg = build_stubbed(:building, short_name: "101")
      wing = build_stubbed(:wing, short_name: "1", visible: false, building: bldg)

      expect(wing.complete_short_name).to eq("101")
    end

  end
end
