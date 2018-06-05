require 'rails_helper'

RSpec.describe MovingTask, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:specialty) }
  it { is_expected.to belong_to(:moving_item) }

  # it { is_expected.to }
end
