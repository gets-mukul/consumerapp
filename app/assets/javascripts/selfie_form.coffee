# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  # initialize variables
  'use strict'
  activeIndex = 0
  fields = $('.scrollable-field')
  inputs = $('.scrollable-field input')
  
  document.getElementById('referrer').value = document.referrer or 'direct'

  setActiveTab = ->
    console.log activeIndex
    fields.removeClass 'active'
    activeField = fields.eq(activeIndex)
    activeField.addClass 'active'
    # fields[activeIndex].scrollIntoView({ behavior: 'smooth' });
    customScrollToElement(fields.eq(activeIndex))
    activeField.find('input').focus()
    return
  
  fields.click ->
    scrollToActiveField this
    return
    
  inputs.focus ->
    scrollToActiveField $(this).closest('.scrollable-field')
    return
    
  inputs.keydown (event) ->
    if event.keyCode == 13 and @validity.valid
      event.preventDefault()
      parent_field = this.closest('.scrollable-field')
      if validate_data(fields.eq(fields.index(parent_field)).find('input'))
        index = fields.index(parent_field)+1
        scrollToActiveField fields[index]
    return

  $('.scroll_to_next').on 'click', (e) ->
    parent_field = this.closest('.scrollable-field')
    if validate_data(fields.eq(fields.index(parent_field)).find('input'))
      index = fields.index(parent_field)+1
      activeIndex = index;
      setActiveTab()
    e.stopPropagation()
    return
  
  scrollToActiveField = (field) ->
    index = fields.index(field)
    if index != activeIndex
      activeIndex = index
      # fields[activeIndex].scrollIntoView({ behavior: 'smooth' });
      customScrollToElement(fields.eq(activeIndex))
      setActiveTab()
    return

  scrollToActiveFieldByIndex = (index) ->
    scrollToActiveField fields.eq(index)
    return
    
  validate_data = (input_field) ->
    value = input_field.val();
    switch input_field.attr('id')
      when 'name'
        if /^[A-z ']{2,}$/.test(value)
          $('#error_name').hide()
          return true
        else
          $('#error_name').show()
          return false
      when 'mobile'
        if /^[0-9]{10,15}$/.test(value)
          $('#error_mobile').hide()
          return true
        else
          $('#error_mobile').show()
          return false
      when 'file_upload'
        if value != ""
          $('#error_file_upload').hide()
          return true
        else
          $('#error_file_upload').show()
          return false
      else
        return true
    return
    
  $('.submit_button').on 'click', (e) ->
    i = 0
    returned_value = true
    while i < inputs.length
      returned_value &= validate_data inputs.eq(i)
      i++
    if !returned_value
      parent_field = $('.wrapper form').find('.alert:visible').eq(0).closest('.scrollable-field')
      activeIndex = fields.index(parent_field)
      e.stopPropagation()
      setActiveTab()
    else
      $('#selfie_form').submit()
    return

  # store email on thank_you page
  $('#store_email').click ->
    mEmail = $("#email").val()
    
    if /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/.test(mEmail)
      $.ajax
        url: "/consult/patients/set_patient_email"
        type: "POST"
        dataType: "html"
        data: { email: mEmail }
        success: (response) ->
          response = JSON.parse(response)
          if response.value == "success"
            console.log "saved"
            $('.email-container div').animate({ opacity: 0 }, 600).remove()
            $('.email-container p label')[0].innerHTML = "We have received your email!"
  
  customScrollToElement = (id) ->
    mOffset =  $(window).height()/2-id.height()/1.3
    $('html,body').animate { scrollTop: id.offset().top-mOffset }, 'slow'
    return


  setActiveTab()

  return
