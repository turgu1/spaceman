module OrgsHelper

  def cache_key_for_orgs
    count          = Org.count
    max_updated_at = Org.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "orgs/all-#{count}-#{max_updated_at}"
  end

end
