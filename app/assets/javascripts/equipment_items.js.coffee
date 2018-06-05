# == Functions used to support the 'equipment_items/equipment_selector' partial

# When a checkbox is clicked:
#   if checked:
#     - The entry is marked to not being destroyed by the server when received
#     - The entry is enabled.
#     - If qty is absent or 0, it is set to 1.
#   if not checked:
#     - The entry is marked to be destroyed by the server when received
#     - The entry is disabled.
#   the corresponding pill is adjusted (see adjust_pill function comment for details)
#
# Parameters:
#
# * +item+ is the input tag related to the check_box or the qty fields.
#
# * +pill_id+ id the id of the 'a' tag corresponding to the pill
#
window.item_check = (item, pill_id) ->
  ctx = $(item).parents('tr')
  if $(item).hasClass('check')
    if item.checked
      ctx.children('#destroy').attr('value', 0)
      ctx.children('#model_id').removeAttr('disabled')
      (qty = ctx.find('#qty')).removeAttr('disabled')
      qty.val(1) if (!qty.val()) || (qty.val() == '0') || (qty.val() == '')
      ctx.find('#notes').removeAttr('disabled')
    else
      ctx.children('#destroy').attr('value', 1)
      ctx.children('#model_id').attr('disabled', 1)
      ctx.find('#qty').attr('disabled', 1)
      ctx.find('#notes').attr('disabled', 1)
  adjust_pill_label(ctx.parents('tbody'), pill_id)

# Adjusts all pills labels to reflect the presence or not of selected equipments.
#
# Parameter:
#
# * +ctx+ represents the whole pills-tabbed div
window.adjust_all_pill_labels = (ctx) ->
  $(ctx).find('#pills > li > a').each(() ->
    adjust_pill_label($($(this).attr('href')+' tbody'), $(this).attr('ident'))
  )

# Modify a pill label such that if there is at least one entry selected in the list of equipment
# associated with it, the label will be prefixed with '* '
#
# Parameters:
#
# * +ctx+ points to the tbody portion of the table
#
# * +pill_id+ is the id of the a tag corresponding to the pill
adjust_pill_label = (ctx, pill_id) ->
  qty = 0
  ctx.find('.check').each(
    () ->
      if $(this).prop('checked')
        the_value = parseInt($(this).closest('tr').find('#qty').prop('value'))
        if the_value
          qty += the_value
  )
  sel = $("[ident='#{pill_id}'] span")[0]
  $(sel).html(if qty == 0 then '' else qty)
