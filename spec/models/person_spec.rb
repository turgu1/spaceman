require 'rails_helper'

RSpec.describe Person, type: :model do

  it { is_expected.to validate_presence_of(:org_id) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:from_date) }

  it { is_expected.to belong_to(:org).inverse_of(:people) }

  it { is_expected.to have_many(:allocations).dependent(:destroy) }
  it { is_expected.to have_many(:requirements).with_foreign_key(:requester_id).dependent(:nullify) }

  it { is_expected.to have_many(:orgs_as_manager).class_name('Org').with_foreign_key(:manager_id).dependent(:nullify) }
  it { is_expected.to have_many(:orgs_as_admin).class_name('Org').with_foreign_key(:admin_id).dependent(:nullify) }

  # it { is_expected.to }
end
