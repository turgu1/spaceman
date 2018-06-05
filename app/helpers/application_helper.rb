module ApplicationHelper

  # Builder used for all record displayed using the usual "show.html" view
  #
  # For example:
  #
  # = show_entry(@report) do |e|
  #   = e.field :name
  #   = e.field :enabled, 'Enabled'
  #   = e.field :group
  #   = e.field :order
  #   = e.field :icon, as: :icon
  #   = e.field :params_script, as: :haml
  #   = e.field :exec_script, as: :ruby
  #   = e.field :view_script, as: :haml

  class Bldr
    include ERB::Util
    def initialize(params)
      @context_obj = params[:target]
    end

    def format_code(source, language = :haml)

      case language
      when :haml
        lexer = Rouge::Lexers::Haml.new
      when :ruby
        lexer = Rouge::Lexers::Ruby.new
      end

      formatter = Rouge::Formatters::HTML.new
      formatter.format(lexer.lex(source)).html_safe
    end

    # Field to be showed.
    #
    # field_name: field name in the record
    # label: a label to use instead of the field name once humanized
    # options: a hash of options.
    #    For now, support only the :as option
    #
    def field(field_name, label = nil, options = {})
      unless label.nil? || (label.class.name == 'String')
        options = label
        label = nil
      end
      unless label
        label = @context_obj.class.human_attribute_name(field_name)
      end
      # :haml, :ruby => source code display pretty printing
      # :icon => show icons in a reasonable size for the operator
      # :yesno => output "Yes" or "No" instead of "true" or "false"
      if options[:as] == :haml
        #val = "<pre>#{@context_obj.send(field_name)}</pre>"
        val = "<pre class=\"highlight\">#{format_code(@context_obj.send(field_name), :haml)}</pre>"
      elsif options[:as] == :ruby
        val = "<pre class=\"highlight\">#{format_code(@context_obj.send(field_name), :ruby)}</pre>"
      elsif options[:as] == :icon
        val = "<i class='#{h(@context_obj.send(field_name))} fa-2x'></i>"
      elsif options[:as] == :yesno
        val = @context_obj.send(field_name) ? I18n.t('cmn.yes') : I18n.t('cmn.no')
      else
        val = h(@context_obj.send(field_name))
      end

      "<dt>#{h(label)}&nbsp;</dt><dd>#{val}</dd>".html_safe
    end
  end

  def show_entry(obj, &block)
    builder = Bldr.new(target: obj)
    output  = capture(builder, &block)
    "<dl class='dl-horizontal'>#{h(output)}</dl>".html_safe
  end

  def req(str)
    "[ #{h(str)} ]"
  end

  def html_notes(txt)
    if txt.blank?
      ''
    else
      " (<i>#{h(txt)}</i>)"
    end
  end

  def format_code_to_html(source, language = :haml)

    case language
    when :haml
      lexer = Rouge::Lexers::Haml.new
    when :ruby
      lexer = Rouge::Lexers::Ruby.new
    end

    formatter = Rouge::Formatters::HTML.new
    formatter.format(lexer.lex(source)).html_safe
  end

  def show_action(entry, options = {})
    classes = (options[:class] || '') + ' btn btn-xs btn-info'
    options[:class] = classes.strip
    remote_link_to(
      t('cmn.show'),
      url_for(controller: entry.class.name.pluralize.underscore, action: 'show', only_path: true, id: entry.id),
      options
    ) if can? :read, entry
  end

  def edit_action(entry, options = {})
    classes = (options[:class] || '') + ' btn btn-xs btn-primary'
    options[:class] = classes.strip
    remote_link_to(
      t('cmn.edit'),
      url_for(controller: entry.class.name.pluralize.underscore, action: 'edit', only_path: true, id: entry.id),
      options
    ) if can? :update, entry
  end

  def delete_action(entry, label, options = {})
    classes = (options[:class] || '') + ' btn btn-xs btn-danger'
    options[:class] = classes.strip
    options[:method] = 'DELETE'
    options['data-toggle'] = 'confirmation'
    options['data-title'] = raw t('cmn.erasing', type: entry.class.model_name.human, item: label)
    link_to(
      t('cmn.destroy'),
      url_for(controller: entry.class.name.pluralize.underscore, action: 'destroy', only_path: true, id: entry.id),
      options
    ) if can? :destroy, entry
  end

  def all_actions(entry, label, options = {})
    "#{show_action(entry)} #{edit_action(entry)} #{delete_action(entry, label, options)}".html_safe
  end

  def show_error(obj, field)
    (content_tag(:span, obj.errors.messages[field].join(','), class: 'help-inline') unless obj.errors.messages[field].size == 0) || ''
  end

  # Create a <a ...>  tag with a push option that will put the entry on the browser pushstack when the
  # link is clicked by the user
  def remote_link_to label, href, options = {}
    options[:push] ||= true
    opt = options[:push] == true ? ',{push: true}' : ''
    options.delete(:push)
    options[:onclick] ||= "call_remote('#{href}'#{opt})"
    options[:style] ||= 'cursor:pointer;'
    options[:href] ||= '#'
    content_tag(:a, label, options)
  end

  def inc_center_index
    i = @center_index
    @center_index += 1
    i
  end
end
