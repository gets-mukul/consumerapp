# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
#  $('strong:contains("Thank You")').click ->
#    window.location.href = '/payment'
  $("#new_patient")
    .on("ajax:success", (e, data, status, xhr) ->
      $("#new_patient").append xhr.responseText)
    .on "ajax:error", (e, xhr, status, error) ->
      $("#error_explanation").text "An error occurred. Please try again later."
