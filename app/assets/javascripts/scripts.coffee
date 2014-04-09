$ ->
  $('.check-all').on 'click', ->
    $(this).parent().next().find('input:checkbox').prop 'checked', true
    return false

  $('.uncheck-all').on 'click', ->
    $(this).parent().next('.has-checkboxes').find('input:checked').prop 'checked', false
    return false
