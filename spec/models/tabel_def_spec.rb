require 'rails_helper'

RSpec.describe TableDef, type: :model do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to accept_nested_attributes_for(:fields).allow_destroy(true) }

  it { is_expected.to have_many(:fields).order(:order).class_name('FieldDef').dependent(:destroy) }

  # it { is_expected.to }
end
