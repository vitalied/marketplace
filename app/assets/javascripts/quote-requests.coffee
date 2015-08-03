$ ->

  addNetwork = (e) ->
    e.preventDefault()

    $('.network-row .summary-panel').removeClass 'hidden'
    $('.network-row .network-fields').addClass 'hidden'

    $.getScript $(@).data 'url'

  handleSummaryPanelClick = ->
    network_row = $(@).closest '.network-row'
    network_row.find('.network-fields').toggleClass 'hidden'

  populateSummaryPanel = (network_row) ->
    summary_panel = network_row.find '.summary-panel'
    network_fields = network_row.find '.network-fields'

    select = network_fields.find('.network select option:selected')
    value = ''
    value = select.text() if select.val() != ''
    summary_panel.find('.network').text value

    select = network_fields.find('.port-speed select option:selected')
    value = ''
    value = select.text() if select.val() != ''
    summary_panel.find('.port-speed').text value

    select = network_fields.find('.access-speed select option:selected')
    value = ''
    value = select.text() if select.val() != ''
    summary_panel.find('.access-speed').text value

    summary_panel.find('.location').text network_fields.find('.location input').val()

  handlePopulate = ->
    network_row = $(@).closest '.network-row'

    populateSummaryPanel network_row

  hideAll = (parent_container) ->
    parent_container.find('.location, .location-z, .line-type, .port-speed, .access-speed, .term, .router, .router-z').addClass 'hidden'

  showInternet = (parent_container) ->
    parent_container.find('.location, .port-speed, .access-speed, .term, .router').removeClass 'hidden'
    parent_container.find('.location-z, .line-type, .router-z, .qos').addClass 'hidden'
    parent_container.find('.location label').text 'Location address'
    parent_container.find('.router .label-text').text 'Do you want Router?'
    parent_container.find('.location-z input').val null
    parent_container.find('.line-type input, .router-z input, .qos input').prop 'checked', false

  showPrivate = (parent_container) ->
    parent_container.find('.location, .location-z, .line-type, .port-speed, .access-speed, .term, .router, .router-z').removeClass 'hidden'
    parent_container.find('.qos').addClass 'hidden'
    parent_container.find('.location label').text 'Location A address'
    parent_container.find('.router .label-text').text 'Do you want Router for Location A?'
    parent_container.find('.qos input').prop 'checked', false

  showOthers = (parent_container) ->
    parent_container.find('.location, .port-speed, .access-speed, .term, .router, .qos').removeClass 'hidden'
    parent_container.find('.location-z, .line-type, .router-z').addClass 'hidden'
    parent_container.find('.location label').text 'Location address'
    parent_container.find('.router .label-text').text 'Do you want Router?'
    parent_container.find('.location-z input').val null
    parent_container.find('.line-type input, .router-z input').prop 'checked', false

  handleNetworkSelect = ->
    _this = $(@)
    network = _this.val()
    parent_container = _this.closest '.network-fields'
    network_row = _this.closest '.network-row'

    if network == ''
      hideAll parent_container
    else if network == 'internet'
      showInternet parent_container
    else if network == 'private'
      showPrivate parent_container
    else
      showOthers parent_container

    populateSummaryPanel network_row

  $(document).on 'click', '.add-network', addNetwork
  $(document).on 'click', '.network-row .summary-panel', handleSummaryPanelClick
  $(document).on 'change', '.network-fields .select-network', handleNetworkSelect
  $(document).on 'change', '.network-fields .port-speed select', handlePopulate
  $(document).on 'change', '.network-fields .access-speed select', handlePopulate
  $(document).on 'change', '.network-fields .location input', handlePopulate

  $('.select2').select2()
