$ ->
  $('.check-all').on 'click', ->
    $(this).parent().next().find('input:checkbox').prop 'checked', true
    return false

  $('.uncheck-all').on 'click', ->
    $(this).parent().next('.has-checkboxes').find('input:checked').prop 'checked', false
    return false

  validateCheckboxes = $('.max-checkboxes')

  $.each validateCheckboxes, ->
    $this = $(this)
    maxAllowed = $(this).data('max-checks')

    $(this).find('input[type=checkbox]').on 'change', ->
      count = $this.find('input:checked').length
      if (count > maxAllowed)
        $(this).prop('checked', '')
        alert('Please only select up to ' + maxAllowed)
