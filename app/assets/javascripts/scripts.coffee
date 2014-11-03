$ ->
  $('#client_vertical').on 'change', ->
    vertical = $(this).val().toLowerCase()
    $('#apartments-fields, #self-storage-fields, #assisted-living-fields').addClass('hidden')
    $('#'+vertical+'-fields').removeClass('hidden')


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

  $(".toggle-location-fields").click ->
    if $(this).text() == "+ Edit All Fields"
      $(this).text("- Hide All Fields")
    else
      $(this).text("+ Edit All Fields")

    $(this).toggleClass("btn-danger")
    $(this).parent().parent().parent().find('#locations_container').slideToggle()

    return false
