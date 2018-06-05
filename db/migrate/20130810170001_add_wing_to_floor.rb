class AddWingToFloor < ActiveRecord::Migration[5.1]
  def change
    add_reference :floors, :wing, index: true
    # reversible do |dir|
    #   dir.up do
    #     Floor.all.includes(:wing).each do |floor|
    #       unless floor.wing
    #         wing = Wing.find_or_create_by(
    #             building_id: floor.building_id,
    #             name: 'Default',
    #             short_name: 'Default')
    #         unless wing.order
    #           wing.order = -99
    #           wing.save
    #         end
    #         floor.wing = wing
    #         floor.save
    #       end
    #     end
    #   end
    # end
  end
end
