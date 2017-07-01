# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require jssocials.min.js
$ ->

  opts =
    lines: 15,
    length: 2.3,
    width: 2.5,
    radius: 13,
    color: '#000',
    speed: 2.1,
    trail: 60,
    shadow: !1,
    hwaccel: !1
    className: 'spinner'
    top: '50%'
    left: '50%'
    position: 'absolute'

  target = $('.loader')[0];
  spinner = new Spinner(opts).spin(target)

  $('#typeform-full').on 'load', ->
    console.log "Typeform loaded"
    spinner.stop()

  manageFormStepsVisibility = ->
    i = 1
    while i <= formSteps
      if i == currentFormStep
        $('#form-step-' + i).removeClass 'hidden'
      else
        $('#form-step-' + i).addClass 'hidden'
      i++
    return


  $('.thanksmsg_popup').hide()

  formSteps = 3
  currentFormStep = 1
  manageFormStepsVisibility()

  $('#form-step-2 .form-stepper-2').on 'click', ->
    condition = $(this).text()
    console.log condition
    window.location.href = '/consult/consultation_form/' + condition
    
  $("#new_patient")
    .on("ajax:success", (e, data, status, xhr) ->
      console.log 'First step clicked'
      currentFormStep++
      manageFormStepsVisibility()

      $('#form-step-2 .form-stepper-2').on 'click', ->
        condition = $(this).text()
        console.log condition
        window.location.href = '/consult/consultation_form/' + condition

    ).on "ajax:error", (e, xhr, status, error) ->
      $("#error_explanation").text "An error occurred. Please try again later."
      console.log e+ xhr+ status+ error
