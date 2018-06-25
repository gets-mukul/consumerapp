# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .
#= require jqBootstrapValidation
#= require spin.min

$(document).on 'turbolinks:load', ->

  $('.swiper-controllers .controller-btn').click ->
    status = $(this).attr('id')
    id = $('.swiper-slide-active .swiper-text .swiper-id').attr('id')
    if id
      conditions = $('.js-example-basic-multiple').val()
      params = {}

      confirmed = false
      if status == 'diagnosed'
        if (conditions != null && conditions.length != 0)
          params = { id: id, status: 'diagnosed', conditions: conditions }
          confirmed = true
        else
          if confirm('Are you sure this person has no conditions?') == true
            params = { id: id, status: "no-condition" }
            confirmed = true
          else
            confirmed = false
      else if status == 'bad-photo'
        if confirm('Are you sure this selfie is not clear?') == true
          params = { id: id, status: 'bad-photo' }
          confirmed = true
        else
          confirmed = false
      else if status == 'no-condition'
        if confirm('Are you sure this person has no skin issues?') == true
          params = { id: id, status: 'no-condition' }
          confirmed = true
        else
          confirmed = false
      else if status == 'recommend-consult'
        if confirm('Confirmation: Are you sure you want to recommend a consultation to this patient?') == true
          params = { id: id, status: 'recommend-consult' }
          confirmed = true
        else
          confirmed = false
      else if status == 'recommend-visiting-a-doctor'
        if confirm('Confirmation: Are you sure you want to recommend visiting a doctor in person?') == true
          params = { id: id, status: 'recommend-visiting-a-doctor' }
          confirmed = true
        else
          confirmed = false

      if confirmed
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

  $('.btn.dropdown-toggle').click ->
    console.log 'clicked'
    $(".dropdown-menu-custom").toggleClass("display-none");

  return
