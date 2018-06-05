# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.selected_toggle = (elem) ->
  $('td.selected').removeClass('selected')
  $(elem).addClass('selected')

window.icon_selected = (event) ->
  if $('.selected i')[0]
    icon_name = $('.selected i').attr('name')
    $('#the-icon').html('<i class="fa fa-' + icon_name + ' fa-2x"></i>')
    $('.icon-field').val('fa fa-' + icon_name)
  hide_modal(event)
