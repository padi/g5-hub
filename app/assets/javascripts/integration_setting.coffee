$ ->
  $("#form-custom-integration-settings").nestedAttributes
    bindAddTo: $("#add_another")
    collectionName: "custom_integration_settings"

  $('.multiselect').multiSelect
    selectableHeader: '<div class="multi-select-header">Available Locations</div>',
    selectionHeader: '<div class="multi-select-header">Selected Locations</div>'

  destroyJobSetting = (doDestroy) ->
    $('#destroy-job-setting').remove()
    if doDestroy
      $('#form-job-setting #job-setting-container').append('<input type="hidden" value=true id="destroy-job-setting" name="clients_integration_setting[integration_setting_attributes][job_setting_attributes][_destroy]"/>')

  leadTypeChanged = (leadType) ->
    return unless $('.job-setting-container.client').length > 0

    if 'inventory' == leadType
      $('#form-job-setting').show()
      destroyJobSetting false
    else
      $('#form-job-setting').hide()
      destroyJobSetting true

  $('#clients_integration_setting_vendor_action').change () ->
    leadTypeChanged $(this).val()

  leadTypeChanged $('#clients_integration_setting_vendor_action').val()
