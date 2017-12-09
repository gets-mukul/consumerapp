# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .
#= require jqBootstrapValidation
#= require spin.min

$(document).ready ->
  # Adds the item to the current list of items
  add_to_list = (str) ->
    ul = document.getElementById('list')
    li = document.createElement('li')
    li.setAttribute 'data-item-type', str
    div = document.createElement('div')
    div.setAttribute 'class', 'box-header with-border'
    h5 = document.createElement('h5')
    h5.appendChild document.createTextNode(str)
    inner_div = document.createElement('div')
    inner_div.setAttribute 'class', 'box-tools pull-right'
    inner_div.innerHTML = '<button type="button" class="btn btn-box-tool remove-button"><i class="fa fa-times"></i></button>'
    div.appendChild h5
    div.appendChild inner_div
    li.appendChild div
    ul.appendChild li
    return

  # Removes elements that already exist in the list and adds the rest to the list.
  $('#add-conditions-btn').on 'click', ->
    existing_keys = Array::slice.call($('#list li h5')).map((x) ->
      x.innerHTML
    )
    keys = $('#key').val()
    keys = keys.exclude(existing_keys)
    if keys.length != 0
      keys.forEach add_to_list
      $('select#key option').removeAttr 'selected'
    return
    
  # Removes the list item
  $('ul#list').on 'click', 'button.remove-button', ->
    $(this).parent().closest('li').remove()
    return

  # Subtracts two arrays
  Array::exclude = (list) ->
    @filter (el) ->
      list.indexOf(el) < 0

  $('.swiper-controllers .btn').click ->
    console.log 'clicked'
    status = $(this).attr('id')
    id = $('.swiper-slide-active .swiper-text .swiper-id').attr('id')
    if id
      conditions = $('.js-example-basic-multiple').val()
      params = {}
      switch status
        when 'diagnosed' then params = { id: id, status: "diagnosed", conditions: conditions }
        when 'bad-photo' then params = { id: id, status: "bad-photo" }
        when 'no-condition' then params = { id: id, status: "no-condition" }
        else console.log ''
      if conditions == null and status = null
        params = { id: id, status: "no-condition" }
      $('.js-example-basic-multiple').val('').trigger('change')
      $('.swiper-button-next').click()
      $.ajax
        url: "/docsapp/save_condition"
        type: "POST"
        dataType: "html"
        data: params
        error: (jqXHR, textStatus, errorThrown) ->
          console.log "something went wrong"
        success: (data, textStatus, jqXHR) ->
          console.log "saved"
