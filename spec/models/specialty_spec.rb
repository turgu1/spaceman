require 'rails_helper'

RSpec.describe Specialty, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:moving_tasks).dependent(:nullify) }

  # it { is_expected.to }
end
