# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#typeform-full').onload = ->
    $('.fa-spin').hide

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

  formSteps = 2
  currentFormStep = 1
  manageFormStepsVisibility()

  $("#new_patient")
    .on("ajax:success", (e, data, status, xhr) ->
      console.log 'First step clicked'
      currentFormStep++
      manageFormStepsVisibility()

      $('#form-step-2 .form-stepper-2').on 'click', ->
        condition = $(this).text()
        console.log condition
        window.location.href = '/consultation_form/' + condition

    ).on "ajax:error", (e, xhr, status, error) ->
      $("#error_explanation").text "An error occurred. Please try again later."
      console.log e+ xhr+ status+ error
