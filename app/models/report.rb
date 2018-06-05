class Report < ApplicationRecord
  scope :all_reports, -> () { all.order(:group, :order, :name) }
  scope :alpha_list, -> () { all.order(:name) }

  validates :name, :order, presence: true
  validates :order, numericality: { only_integer: true }

  # Take care of the changes in the font_awsome icon names. Now, instead of
  # "icon-something" we must return "fa fa-something"
  def the_icon
    icon.sub(/^icon\-/, 'fa fa-')
  end
end
