require 'rails_helper'

RSpec.describe Report, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  # it { is_expected.to }
end
