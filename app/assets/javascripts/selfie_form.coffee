# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

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
      ga('send', 'event', { eventCategory: 'selfieFormPage', eventAction: 'clickEmailButton' });
  
  return
