require 'rails_helper'

RSpec.describe Import, type: :model do

  it { is_expected.to validate_presence_of(:import_file) }

  # it { is_expected.to }
end
