require 'rails_helper'

RSpec.describe FieldDef, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:table_def) }

  # it { is_expected.to }
end
