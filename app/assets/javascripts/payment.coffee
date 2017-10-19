# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#shareButtonLabelCount').jsSocials
    showCount: true
    showLabel: true
    shares: [
      'twitter'
      'facebook'
      'googleplus'
      'linkedin'
      'pinterest'
      'stumbleupon'
      'whatsapp'
    ]

  $('#shareButton').click ->
    $('#shareButtonLabelCount').slideDown 'slow', 'swing'

  $('#shareGiftButtonLabelCount').jsSocials
    showCount: false
    showLabel: false
    text: "Happy Diwali! Here's Rs.100 off an online consultation with Remedico. With Remedico you can consult with dermatologists without having to make appointments, or waste time visiting clinics. Check it out"
    shares: [
      { share: "whatsapp", url: "https://goo.gl/1hLAJB" },
      { share: "twitter", url: "https://goo.gl/nDLHSN", text: "Happy Diwali! Here's Rs.100 off an online consultation with Remedico. Check it out", hashtags: "Remedico, DiwaliOFF" },
      { share: "facebook", url: "https://goo.gl/L5v2UK" },
      { share: "messenger", url: "https://goo.gl/L5v2UK" },
      { share: "googleplus", url: "https://goo.gl/oKqv3W" },
      { share: "linkedin", url: "https://goo.gl/8K4WjP" },
      { share: "pinterest", url: "https://goo.gl/MN8bTm" },
      { share: "email", url: "https://goo.gl/6ipPrz", logo: "fa fa-envelope-o", }
    ]
