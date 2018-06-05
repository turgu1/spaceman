require 'rails_helper'

RSpec.describe SpaceType, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:spaces).inverse_of(:space_type).dependent(:nullify) }
  it { is_expected.to have_many(:equipment_items).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:equipment_items).allow_destroy(true) }

  it 'builds a sorted floors array with each entry having { floor: floor, spaces: [spaces] }' do
    space_type = create(:space_type)
    floor = create(:floor)
    space = create(:space, floor: floor, space_type: space_type)
    floors = space_type.associated_floors
    expect(floors.count).to eq(1)
    expect(floors[0]).to eq(floor)
    expect(floors[0].spaces.count).to eq(1)
    expect(floors[0].spaces[0]).to eq(space)
  end

  # it { is_expected.to }
end
