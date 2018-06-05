require 'rails_helper'

RSpec.describe Requirement, type: :model do

  it { is_expected.to validate_presence_of(:project_name) }
  it { is_expected.to validate_presence_of(:from_date) }
  it { is_expected.to validate_presence_of(:org_id) }

  it { is_expected.to belong_to(:org).inverse_of(:requirements) }
  it { is_expected.to belong_to(:person).with_foreign_key(:requester_id) }

  it { is_expected.to have_many(:allocations).dependent(:destroy) }

  # it { is_expected.to }
end
