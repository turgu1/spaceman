require 'rails_helper'

RSpec.describe Org, type: :model do

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:abbreviation) }

  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to validate_uniqueness_of(:abbreviation) }

  it { is_expected.to validate_numericality_of(:order).only_integer }

  it { is_expected.to accept_nested_attributes_for(:people) }
  it { is_expected.to accept_nested_attributes_for(:requirements) }

  it { is_expected.to belong_to(:manager).class_name('Person').with_foreign_key(:manager_id) }
  it { is_expected.to belong_to(:admin).class_name('Person').with_foreign_key(:admin_id) }

  it { is_expected.to have_many(:people).order([:last_name, :first_name]).dependent(:destroy) }
  it { is_expected.to have_many(:requirements).order(:project_name).dependent(:destroy) }

  # it { is_expected.to }
end
