# Used to detect initial (useless) popstate.
# If history.state exists, assume browser isn't going to fire initial popstate.
# popped = ('state' in window.History)
# initialURL = location.href

flash_timeout = null

# This function is called at page load time
$ ->

  $(document).ajaxStart(() -> $('body').addClass('busy'))
  $(document).ajaxStop(()  -> $('body').removeClass('busy'))

  on_ajax_load()

  # Still not working...
  # $(window).bind("popstate", (event) ->
  #   alert("location: " + document.location + ", state: " + JSON.stringify(event.state))
  #   if event.state != undefined then call_remote(document.location, event.state))

  #   # Ignore inital popstate that some browsers fire on page load
  #   initialPop = !popped && location.href == initialURL
  #   popped = true
  #   return if initialPop

  #   event.preventDefault()
  #   $.getScript(location.href)
  #   return false
  # )

  $(document).on('nested:fieldAdded', (event) -> on_field_added(event))

  $('#flash-pane').on('DOMSubtreeModified', (event) -> check_flash_change())

  check_flash_change()

window.check_flash_change = () ->
  if $('#flash-pane').html().trim() != ''
    clearTimeout(flash_timeout) if flash_timeout != null
    flash_timeout = setTimeout(
      () -> $('#flash-pane>div').alert('close')
      4000)

#  History = window.History # Note: We are using a capital H instead of a lower h
#  if (History.enabled)
#    State = History.getState();
#    # set initial state to first page that was loaded
#    History.pushState({urlPath: window.location.pathname}, $("title").text(), State.urlPath);
#  else
#    # History.js is disabled for this browser.
#    # This is because we can optionally choose to support HTML4 browsers or not.
#    return false

# This function is called both at page load time and after ajax calls.
window.on_ajax_load = () ->

  # Initialize date picker prefered date format
  $('.datepicker')  .datepicker({ format: 'yyyy-mm-dd' })

  # Adjust tables to be presented as condensed and striped. The no-strip class prevent a
  # table to be striped...
  $('table')        .addClass('table table-condensed').not('.no-strip').addClass('table-striped')

  # Insure that links wont be printed
  $('a')            .addClass('no-print')

  # An easy way to tag buttons to be shown with as small ones with the blue background
  $('.smallbtn')    .addClass('btn btn-primary btn-sm smalll')
  $('.xsmallbtn')   .addClass('btn btn-primary btn-xs smalll')

  # An easy way to tag input fields as Bootstrap form-control
  $('form input').not('.btn').not('.file').not('[type="checkbox"]').not('[type="radio"]').addClass('form-control')
  $('form select')  .addClass('form-control')
  $('form textarea').addClass('form-control')

  # Adjusts all pills labels to reflect the presence or not of selected equipments.
  $('#equipment_selection').each(() -> adjust_all_pill_labels($(this)))

  # ACE editor configuration for ruby and haml scripts
  $('.code-ruby').ace({ lang: 'ruby', height: 400, width: 'auto', theme: 'twilight' })
  $('.code-haml').ace({ lang: 'haml', height: 400, width: 'auto', theme: 'twilight' })
  $('pre').addClass('pre-scrollable')

  $('[data-toggle=confirmation]').confirmation({
    rootSelector: '[data-toggle=confirmation]',
    onConfirm: () ->
      call_remote($(this).attr('href'), {
        type:                 $(this).attr('data-method'),
        the_object:           $(this)
        right_column_state:   $(this).attr('data-right-column-state'),
        center_column_state:  $(this).attr('data-center-column-state') })
    buttons: [
      {
        class: 'btn btn-xs btn-primary',
        icon: 'glyphicon glyphicon-ok',
        label: 'Yes'
      },
      {
        class: 'btn btn-xs btn-default',
        icon: 'glyphicon glyphicon-remove',
        label: 'No',
        cancel: true
      }]})

  # For nested forms, associate an event to adjust new fields loaded
  $('.nested-container').on('cocoon:after-insert', () -> on_ajax_load())

  # An easy way to identify a focused field at load time
  $('.focus').focus()

  # As we need to insure that image-maps are not going to be called twice with mapster,
  # we check the presence of a 'mapster-tag' class and if not present, we call
  # mapster and *then* apply the 'mapster-tag' to the image.

  $('.img-map.multi-select').not('.mapster-tag')
    .mapster({
      fillOpacity:      0.2,
      render_highlight: { fillColor: '777777', strokeWidth: 1, stroke: true },
      render_select:    { fillColor: '111111', stroke: false },
      mapKey:           'key',
      onConfigured: () -> check_size(this); clear_selection()})
    .addClass('mapster-tag')

  $('.img-map.highlight').not('.mapster-tag')
    .mapster({
      fillOpacity:      0.2,
      isSelectable:     false,
      clickNavigate:    true,
      render_highlight: { fillColor: '3276b1', strokeWidth: 1, stroke: true },
      onConfigured:     () -> check_size(this)})
    .addClass('mapster-tag')

  # This is used to resize images that are hidden inside accordion panels. Usually related
  # to level localisation images on the left sidebar of the application

  $('img.resize-in-panel')
    .not('.mapster_el')
    .each(() ->
      $(this).mapster('resize', $(this).parents('.panel-body').prev().width())
      $(this).css('display', 'block') # Was none to limit flickering on screen
    )

  # This is to insure that floor images shown in the center of screen won't take
  # too much of space real estate

  # $('img.resize').each(() ->
  #   $(this).css('display', 'block')

#  $('img.resize').each(() ->
#    if $(this).height() > 400
#      $(this).mapster('resize', null, 400))

  # Insure that droppable and draggable are not tagged twice checking for the presence
  # of 'ui-droppable' and 'ui-draggable' classes

  $('.droppable').not('.ui-droppable').droppable({
    tolerance: 'pointer',
    accept: () -> return accept_drop(),
    drop: (event, ui) -> 
      if (! $('.already-dropped').length)
        $('body').addClass('already-dropped')
        setTimeout(
          () -> $('.already-dropped').removeClass('already-dropped'),
          100)
        event.stopPropagation(); 
        check_drop(event, ui, this); 
        return false
    })

  $('.draggable').not('.ui-draggable').draggable({
    cursor: 'hand',
    helper: 'clone'})

  # Build the map areas structure required to compute the area selected at drop time
  map_area_for_drop()

  # Set mouse cursor in case of coordinate entry contexts
  set_cursor()

  $('.panel-body.collapse').on('show.bs.collapse', (event) ->
    sessionStorage.setItem($(this).attr('id'), '1'))

  $('.panel-body.collapse').on('hide.bs.collapse', (event) ->
    sessionStorage.setItem($(this).attr('id'), '0'))

  $('.panel-body.collapse').each(() ->
    if sessionStorage.getItem($(this).attr('id')) == '1'
      if !$(this).hasClass('in')
        $(this).collapse('show')
    else
      if $(this).hasClass('in')
        $(this).collapse('hide'))

window.on_field_added = (event) ->
  event.field.find('.auto-date').not('.date-set').each( () ->
    if $(this).val() == ''
      theDate = new Date()
      $(this).val(
        theDate.getFullYear() + '-' +
        ('0' + (theDate.getMonth() + 1)).slice(-2) + '-' +
        ('0' +  theDate.getDate()).slice(-2))).addClass('date-set')
  event.field.find('.auto-check').not('.check-done').prop('checked', true).addClass('check-done')
  on_ajax_load()

#  $('.dropdown-toggle').dropdown()
#  $("html").bind("ajaxStart", () ->
#    $(this).addClass('busy')
#  ).bind("ajaxStop", () ->
#    $(this).removeClass('busy')
#  )

$(document).ajaxComplete((event, requirement) ->
#  flash = requirement.getResponseHeader('X-Flash-Messages');
#  if (!flash)
#    $('#flash-pane').html('')
#  else
#    $('#flash-pane').html(flash)
  on_ajax_load())

# Called by returning code from the server to append a new object to a selected list of
# data
window.append_content = (selector, with_content) ->
  $(selector).append(with_content);

# Called by returning code from the server to replace the html content of a DOM object
# identified using a jquery selector
window.replace_content = (selector, with_content) ->
  $(selector).html(with_content)
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text('Fetching more documents...')
        $.getScript(url)
    $(window).scroll()
  on_ajax_load()

# Well, their may be still some flicker, but less annoying...
window.replace_content_no_flicker = (selector, with_content) ->
  next = $(selector).attr('nxt-load')
  unless next
    $(selector).html('<div id="a"></div><div id="b"></div>')
    $(selector).attr('nxt-load', 'a')
    next = 'a'
  target = "#{selector} ##{next}"
  n = if next == 'a' then 'b' else 'a'
  other = "#{selector} ##{n}"
  $(target).hide()
  $(target).html(with_content)
  img = $("#{target} img").first()

  if img.length > 0
    img.load(() ->
      sel = '#' + $(this).closest('[nxt-load]').attr('id')
      nxt = $(sel).attr('nxt-load')
      oth = if nxt == 'a' then 'b' else 'a'
      $("#{sel} ##{oth}").hide()
      $("#{sel} ##{nxt}").show()
      $(sel).attr('nxt-load', oth))
  else
    $(other).hide()
    $(target).show()
    $(selector).attr('nxt-load', n)

# Called by returning code from the server to replace the value attribute of a DOM object with
# the prepared payload coming from the server. The selector is a jquery valid selector.
window.replace_value = (selector, with_content) ->
  $(selector).attr('value', with_content)

# Ajax call with a complete url
# Options can be a string or an object with parameters
window.call_remote = (url, options = 'GET') ->
  if typeof options == 'string'
    options = { type: options }
  if options.type == undefined
    $.extend(options, { type: 'GET' })
  if options.dataType == undefined
    $.extend(options, { dataType: 'script' })

  pushIt = options.push == true
  delete options.push

  right_state = options.right_column_state
  delete options.right_column_state

  center_state = options.center_column_state
  delete options.center_column_state

  the_object = options.the_object
  delete options.the_object

  # if pushIt
  #   alert("pushState location: " + url + ", state: " + JSON.stringify(options))
  #   window.history.pushState(options, '', url)

  # The right column on screen can displays an organisation list of people and requirements.
  # If present and requested, the current state of the right column is sent back as
  # three parameters to the server

  if right_state && $('#right-column-org-showned').length
    first = if url.indexOf('?') > 0 then '&' else '?'
    url = url + first + 'right_showned_org_id=' + $('#right-column-org-showned').attr('data-org-id')

  if center_state
    first = if url.indexOf('?') > 0 then '&' else '?'
    url = url + first +
      'center_entity_showned=' + $(the_object).closest('.entity-allocations').attr('data-entity') +
      '&center_entity_id='     + $(the_object).closest('.entity-allocations').attr('data-entity-id') +
      '&center_target='        + $(the_object).closest('.entity-allocations').attr('id') +
      '&center_floor_id='      + $(the_object).closest('.entity-allocations').attr('data-floor-id')

  res = $.ajax($.extend({
    url: url,
    cache: false
  }, options))

  return res

# Ajax call with a single dynamic parameter
window.call_remote_with_param = (url, params) ->
  $.ajax({
    type: 'GET',
    url: url,
    data: params,
    cache: false,
    dataType: 'script'
    # success: (data) -> eval(data)
  })

# This is used to hide a modal dialog when an associated button is pressed
window.hide_modal = (event) ->
  event.preventDefault()
  $('#modal-dialog').modal('hide')

# This is to insure that floor images shown in the center of screen won't take
# too much of space real estate
check_size = (image) ->
  $(image).filter('.resize').each(() ->
    if $(this).height() > 400
      $(this).mapster('resize', null, 400)
      map_area_for_drop()
    $(this).css('display', 'block') # Was none to limit flickering on screen
  )
