module RequirementsHelper

  def can_create_requirement?(org_id)
    unless current_user.nil?
      org_ids = current_user.orgs_to_man
      can?(:create, Requirement) && (current_user.man_all_org || !org_ids.index(org_id).nil?)
    end
  end

  def can_create_person?(org_id)
    unless current_user.nil?
      org_ids = current_user.orgs_to_man
      can?(:create, Person) && (current_user.man_all_org || !org_ids.index(org_id).nil?)
    end
  end
end
