$ ->
  $("#form-custom-integration-settings").nestedAttributes
    bindAddTo: $("#add_another")
    collectionName: "custom_integration_settings"

  $('.multiselect').multiSelect
    selectableHeader: '<div class="multi-select-header">Available Locations</div>',
    selectionHeader: '<div class="multi-select-header">Selected Locations</div>'
