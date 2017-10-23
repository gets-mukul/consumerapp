# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('#shareButtonLabelCount').jsSocials
    showCount: false
    showLabel: false
    text: "I just did a consultation with a dermatologist online on Remedico - should definitely try it!"
    url: "remedicohealth.com"
    shares: [
      { share: "whatsapp", url: "I just did a consultation with a dermatologist online on Remedico - you should try it! remedicohealth.com" },
      { share: "twitter", url: "With @remedicohealth you can now consult with dermatologists online remedicohealth.com", hashtags: "Remedico, Healthcare" },
      { share: "facebook" },
      { share: "messenger" },
      { share: "googleplus" },
      { share: "linkedin" },
      { share: "pinterest" },
      { share: "email", logo: "fa fa-envelope-o", }
    ]

  $('#shareButton').click ->
    $('#shareButtonLabelCount').slideDown 'slow', 'swing'
