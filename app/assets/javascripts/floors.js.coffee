# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Variable utilisée afin de conserver l'état de l'évènement onClick qui peut
# être lancé par l'utilisateur, soit pour lancer l'édition des données d'un
# espace existant, soit pour saisir les coordonnées du polygone associé à une
# nouvel espace.

on_click_state = 0

window.findPosX = (obj) ->
  curleft = 0;
  if obj.offsetParent
    while true
      curleft += obj.offsetLeft
      break if (!obj.offsetParent)
      obj = obj.offsetParent;
  else
    curleft += obj.x if (obj.x)
  return curleft

window.findPosY = (obj) ->
  curtop = 0
  if obj.offsetParent
    while true
      curtop += obj.offsetTop;
      break if !obj.offsetParent
      obj = obj.offsetParent
  else
    curtop += obj.y if obj.y
  return curtop

window.aOnClick = (e, a, field = '#space_coor') ->
  x = 0
  y = 0
  isOpera = window.opera
  isIE    = !isOpera && document.all

  # Cette fonction ne devrait être appelée que pour saisir les coordonnées
  # de la position du curseur, dans le contexte de la saisie du polygone définissant
  # l'emplacement d'un espace.
  #
  # Comme les espaces existants dans le dessin possèdent également un
  # évènement onClick pour commander l'édition de l'espace en question,
  # la variabe on_click_state permet d'empêcher l'exécution de la fonction
  # de recupération des coordonnées du pointeur et cela, pour ne pas brouiller
  # l'utilisateur.

  if on_click_state == 1
    on_click_state = 0
    return

  e = window.event if !e
  if e.pageX || e.pageY
    x = e.pageX
    y = e.pageY
  else
    if e.clientX || e.clientY
      x = e.clientX
      y = e.clientY
      if isIE
        x += document.documentElement.scrollLeft
        y += document.documentElement.scrollTop

  x -= findPosX($(a)[0])
  y -= findPosY($(a)[0])

  data = $(field)[0]
  unless data == undefined
    if data.value.length == 0
      data.value = x + "," + y
    else
      data.value += "," + x + "," + y

# Area selection management functions. This requires that only one image is set on the
# screen with multi-select feature (through class 'multi-select' added to the img tag).

# Contains the list of spaces selected by the user
the_selection = []
the_image = null

window.init_selection = (image) ->
  the_selection = []
  the_image = image

window.get_selection = () ->
  the_selection

window.show_selection = () ->
  console.log('selection = ' + the_selection)
  console.log('image = ' + the_image)

window.clear_selection = () ->
  $(the_image).mapster('set', false, id) for id in the_selection
  the_selection = []

the_selection = []

# This function will toggle the state of selection for all areas in the image.
# It construct to strings (on_keys, off_keys) with the spaces ids that are in the
# key attribute of each area. These will be passed to mapster to change the visual state
# of the areas. A new_selection array is also prepared and will replace the_selection
# array once all computation completed at the end of the function. The *adjust space type*
# button is set accordingly to the new selection state. The algorithm is such that it
# minimizes the amount of time mapster is being call as the process of iteration on
# setting the areas is rather slow.
window.toggle_all_spaces = (selector) ->
  on_keys = ""
  off_keys = ""
  new_selection = []
  comma = ''
  for id in the_selection
    off_keys += comma + id
    comma = ','

  comma = ''
  $(selector).each(() ->
    id = $(this).attr('key')
    if the_selection.indexOf(id) == -1
      new_selection.push id
      on_keys += comma + id
      comma = ',')
  $(the_image).mapster('set', false, off_keys)
  $(the_image).mapster('set', true, on_keys) unless $(new_selection).size() == 0
  the_selection = new_selection
  check_adjust_button()

# This function is called when a space (an img area) has been clicked on by the user.
window.space_selected = (event, area, id, url) ->
  # If the special key is there, that means a space is added/removed from the selected items
  theKey = if navigator.platform.toUpperCase().indexOf('MAC') != -1 then event.metaKey else event.ctrlKey

  if theKey
    toggle_space_selection(id)
  else
    clear_selection()
    $(the_image).mapster('set', true, id)
    event.stopPropagation()
    call_remote(url)
  check_adjust_button()

toggle_space_selection = (id) ->
  # Toggle space selection
  if (idx = the_selection.indexOf(id)) == -1
    the_selection.push id
    $(the_image).mapster('set', false, id)
  else
    the_selection.splice(idx, 1)
    $(the_image).mapster('set', true, id)

# If there is at least an entry in the selection, show the action button to the user
check_adjust_button = () ->
  if $(the_selection).size() > 0
    $('.adjust-button').removeClass('hide')
  else
    $('.adjust-button').addClass('hide')

window.allowDrop = (event) -> event.preventDefault()

# Functions to identify which area the mouse cursor was in at drop time
pnpoly = (nvert, vertx, verty, testx, testy) ->
  #  Point in Poly Test http://www.ecse.rpi.edu/~wrf/Research/Short_Notes/pnpoly.html
  c = false;
  j = nvert - 1
  for i in [0..nvert-1]
    c = !c if (((verty[i] > testy) != (verty[j] > testy)) &&
         (testx < (vertx[j] - vertx[i]) * (testy - verty[i]) / (verty[j] - verty[i]) + vertx[i]))
    j = i
  return c

pnrect = (vertx, verty, testx, testy) ->
  return (vertx[0] <= testx) && (testx <= vertx[1]) && (verty[0] <= testy) && (testy <= verty[1])

area = []

window.map_area_for_drop = () ->
  $('.space-area').each((i) ->
    # This creates an array of area polygon objects so that we can test when an item has been dropped inside of one
    area[i] = {} # creates a new object which will have properties for id, x coordinates, and y coordinates
    area[i].id = $(this).attr("id")
    area[i].x = []
    area[i].y = []
    area[i].shape = $(this).attr("shape")

    coords = JSON.parse('[' + $(this).attr("coords") + ']')
    totalPairs = coords.length / 2
    coordCounter = 0 # variable to double iterate

    for ix in [0..totalPairs-1] # fill arrays of x/y coordinates for pnpoly
      area[i].x[ix] = coords[coordCounter]
      area[i].y[ix] = coords[coordCounter + 1]
      coordCounter += 2)

dropTarget = (dropX, dropY) ->
  target = 'invalid';

  for i in [0..area.length-1]
    if area[i].shape == 'poly'
      if pnpoly(area[i].x.length, area[i].x, area[i].y, dropX, dropY)
        target = area[i].id
        break
    else
      if pnrect(area[i].x, area[i].y, dropX, dropY)
        target = area[i].id
        break

  return target

# Following a drag and drop movement by the user, this method find in which area the mouse cursor was in and
# call the auto_new action of allocations to quickly add a new allocation. Does nothing if the
# mouse cursor location doesn't point at a map area.
window.check_drop = (event, ui, elem) ->

  x1 = event.pageX - $(elem).offset().left # ui.offset.left # + (ui.draggable.width()  / 2)  # establishes the center of the object to use for testing x,y
  y1 = event.pageY - $(elem).offset().top  # ui.offset.top  # + (ui.draggable.height() / 2)

  result = dropTarget(x1, y1) # returns id of area or 'invalid'

  unless result == 'invalid'
    if ui.draggable[0].type == 'Person'
      field = 'person_id'
    else
      field = 'requirement_id'
    call_remote(
      '/allocations/auto_new.js?space_id=' + result + '&' + field + '=' + ui.draggable[0].id,
      { right_column_state: true, center_column_state: true, the_object: elem })

  return false

current_cursor = 0

window.set_cursor = () ->
  $('.space-edit').addClass('cursor-' + current_cursor)
  $('.cursor-select').addClass('cursor-' + current_cursor)

window.remove_cursor = () ->
  $('.space-edit').removeClass('cursor-' + current_cursor)
  $('.cursor-select').removeClass('cursor-' + current_cursor)

window.change_cursor = () ->
  remove_cursor()
  current_cursor += 1
  current_cursor = 0 if current_cursor > 2
  set_cursor()