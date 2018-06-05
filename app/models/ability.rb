class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :update_password, User, id: user.id
    can :update_language, User, id: user.id
    if user.role? :admin
      can :manage, :all
      cannot :destroy, User, id: user.id  # Insure that an admin user cannot delete himself!
    else
      can :read, :all
      cannot :read, User
      if user.role? :pilot
        can :manage, :all
        cannot :manage, User
        cannot(:manage, Report) unless user.role? :reports
      else
        if user.role? :backup
          can :backup, :database
        end
        if user.role? :import
          can :import, :database
        end
        if user.role? :buildings
          building_ids = user.buildings_to_man
          if user.man_all_building
            can :manage, [Building, Wing, Floor, Space]
          elsif building_ids.length > 0
            can :manage, Building, id: building_ids
            can :manage, Wing,     building_id: building_ids
            can :manage, Floor,    wing: { building_id: building_ids }
            can :manage, Space,    floor: { wing: { building_id: building_ids }}
            cannot [:destroy, :create], Building
          end
        end
        if user.role? :allocations
          building_ids = user.buildings_to_man
          org_ids = user.orgs_to_man
          if user.man_all_building && user.man_all_org
            can :manage, Allocation
          elsif user.man_all_building
            can :manage, Allocation, consumer: { org: org_ids }
          elsif user.man_all_org
            can :manage, Allocation, space: { floor: { building_id: building_ids }}
          else
            can :manage, Allocation, space: { floor: { building_id: building_ids }}, consumer: { org_id: org_ids }
            can :manage, Allocation, space: { floor: { building_id: building_ids }}, consumer_id: nil
          end
        end
        if user.role? :organisations
          org_ids = user.orgs_to_man
          if user.man_all_org
            can :manage, [Org, Person]
          elsif org_ids.length > 0
            can :manage, Org,    id: org_ids
            can :manage, Person, org_id: org_ids
            cannot [:destroy, :create], Org
          end
        end
        if user.role? :requirements
          org_ids = user.orgs_to_man
          can :create, Requirement  # This require support for creations in a context of an org...
          if org_ids.length > 0
            can [:update, :destroy], Requirement, org_id: org_ids
          else
            can [:update, :destroy], Requirement
          end
        end
        if user.role? :space_types
          can :manage, SpaceType
          can :manage, EquipmentItem, itemable_type: 'SpaceType'
        end
        if user.role? :equipments
          can :manage, [EquipmentGroup, EquipmentModel]
        end
        if user.role? :reports
          can :manage, [Report]
        end
      end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end

# Rules for the SpaceMan application:
#
# Role Admin: Can do anything
# Role Pilot: Can do anything, but cannot administer Users
# Role Buildings: Two conditions:
#    - Can manage buildings, Wings, Floors, Spaces for the buildings identified in buildings_to_man, but he cannot
#      create or destroy any building
#    - Can manage all buildings, Floors, Spaces if man_all_buildings is true
# Role Orgs: Two conditions:
#    - Can manage Orgs, People for the orgs identified in orgs_to_man, but he cannot
#      create or destroy any org
#    - Can manage all Orgs, People if man_all_orgs is true
#
# ToDo: Complete the documentation
