# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  # social share button properties
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

  # social share button on click display
  $('#shareButton').click ->
    $('#shareButtonLabelCount').slideDown 'slow', 'swing'

  # accordion section
  $('.collapsible-section h5').click (e) ->
    if $(this).next().is(':hidden')
      $(this).next().slideDown()
      $(e.target).parent().addBack().find('.more-less').removeClass 'fa-plus'
      $(e.target).parent().addBack().find('.more-less').addClass 'fa-minus'
      ga('send', 'event', { eventCategory: 'paymentsPage', eventAction: 'clickExpandAccordion', eventLabel: $(this)[0].innerText});
      mixpanel.track("Payments Page Accordion Clicked", {
        "Page URL": "payment/index",
        "Value": $(this)[0].innerText
      });
    else
      $(this).next().slideUp()
      $(e.target).parent().addBack().find('.more-less').removeClass 'fa-minus'
      $(e.target).parent().addBack().find('.more-less').addClass 'fa-plus'
    return

  # payment options icon click
  $('.payment-option').click (e) ->
    ga('send', 'event', { eventCategory: 'paymentsPage', eventAction: 'clickDisplayPaymentOption', eventLabel: $(this)[0].title});
    mixpanel.track("Payments Page Display Payment Option Clicked", {
      "Page URL": "payment/index",
      "Value": $(this)[0].title
    });
    $('#payBtn').click()
