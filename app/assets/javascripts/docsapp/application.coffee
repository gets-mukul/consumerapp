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

  $('.swiper-controllers .btn').click ->
    status = $(this).attr('id')
    id = $('.swiper-slide-active .swiper-text .swiper-id').attr('id')
    if id
      conditions = $('.js-example-basic-multiple').val()
      params = {}

      confirmed = false
      if status == 'diagnosed'
        if conditions != null
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

  return
