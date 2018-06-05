module FloorsHelper

  def alloc_list(space)
    allocs = space.allocations # ... _in_range(session)
    l = ""
    unless allocs.nil?
      sep = ": "
      allocs.each do |a|
        l = l + sep + a.consumer_name
        sep = "; "
      end
    end
    return l
  end

  def space_title(space)
    "Local #{h(space.name)} "\
    "#{h(alloc_list(space))}"\
    "&#10;Space Type: #{space.space_type.nil? ? 'NOT DEFINED!' : h(space.space_type.name) }"\
    "#{space.function.blank? ? '' : '&#10;Function: ' + space.function}".html_safe
  end

  def space_list(spaces)
    spaces.map { |s| Space.find(s.to_i).name }.join(', ')
  end

  def label_with_link(label, btn_label, link)
    "#{link_to btn_label, link, class: 'smallbtn'}&nbsp;&nbsp;#{label}".html_safe
  end
end
