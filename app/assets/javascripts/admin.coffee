$ ->

  window.backURLs = []


  performSearch = (custom_data) ->
    form = $('.search-form')
    data = form.serialize()
    if custom_data
      data += '&' + $.param(custom_data)

    $.get form.attr('action'),
          data,
          null,
          'script'

  doSearch = ->
    performSearch()

  clearSearch = ->
    $('.search-form .search-input').val ''

    performSearch()

  $(document).on 'input', '.search-form .search-input', doSearch
  $(document).on 'click', '.search-form .search-clear', clearSearch


  loadMore = ->
    url = $('.pagination .next a[rel=next]').attr 'href'

    if url && $('.page-content-list').scrollTop() > $('.list-table-container').height() - $('.page-content-list').height() - 185
      $('.pagination').remove()
      $.getScript url

  $('.page-content-list').on 'scroll', loadMore
  loadMore()


  showProfile = (url) ->
    if url
      $.getScript url, showHideBackLink


  listClick = ->
    window.backURLs = []
    showProfile $(@).data 'item-url'

  $(document).on 'click', '.list-table tbody tr', listClick


  $.datepicker.setDefaults
    dateFormat: "yy-mm-dd"

  successInPlaceEdit = ->
    showProfile $(@).closest('[data-object-url]').data 'object-url'

  $(document).on 'ajax:success', '.best-in-place', successInPlaceEdit

  $('.best-in-place').best_in_place()

  # first, find the mount point
  $('body').on 'best_in_place:activate', '.best_in_place', ->

    # second, attach empty update() to `this` to screen the downstream calls
    # which otherwise will cause an error
    @update = ->

    searchURL = $(@).data 'search-url'

    # now unbind `blur` from the <select> and bind it to the downstream
    # best_in_place's handler; this prevents the immediate select2's
    # destruction since clicking on it would cause `blur` on the downstream
    # best_in_place
    $(@).find('.select2').select2(
      ajax:
        url: searchURL
        dataType: 'json'
        delay: 1
        data: (params) ->
          q: params.term, # search term
          page: params.page
        processResults: (data, params) ->
          # parse the results into the format expected by Select2
          # since we are using custom formatting functions we do not need to
          # alter the remote JSON data, except to indicate that infinite
          # scrolling can be used
          params.page ||= 1

          results: data.items
          pagination:
            more: (params.page * 25) < data.total_count
        cache: true
    ).unbind('blur').bind 'blur', { editor: @ }, BestInPlaceEditor.forms.select.blurHandler


  showHideBackLink = ->
    back_link = $('a.back-link')
    if window.backURLs.length > 0
      back_link.show()
    else
      back_link.hide()

  backLink = (e) ->
    e.preventDefault()

    showProfile window.backURLs.pop()

  nextLink = (e) ->
    e.preventDefault()

    e_target = $(e.target)

    if e_target.is('.next-link') || e_target.parent().is '.next-link'
      window.backURLs.push $(@).closest('[data-object-url]').data 'object-url'
      showProfile $(@).data 'next-url'
    else
      false

  optionsNextLink = (e) ->
    window.backURLs.push $(@).data 'object-url'

  $(document).on 'click', 'a.back-link', backLink
  $(document).on 'click', 'a.next-link', nextLink
  $(document).on 'click', 'a.options-next-link', optionsNextLink
