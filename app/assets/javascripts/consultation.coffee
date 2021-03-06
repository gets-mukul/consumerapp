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
    spinner.stop()

  $('.thanksmsg_popup').hide()

  $('#my-form-step .form-stepper-2').on 'click', ->
    condition = $(this).attr('value')
    console.log condition
    btnname = 'click'    
    switch condition
      when 'Eczema, Psoriasis and Rash' then btnname += 'Rash'
      when 'Skin Growth (Moles, Warts)' then btnname += 'SkinGrowths'
      when 'Stretch Marks' then btnname += 'StretchMarks'
      when 'Hairfall or Hair Thinning' then btnname += 'Hairfall'
      when 'Pigmentation, Tanning and Dark Circles' then btnname += 'Pigmentation'
      when 'General Skin Care' then btnname += 'GeneralSkinCare'
      else btnname += condition
    btnname += 'Button'
    ga('send', 'event', { eventCategory: 'consultation', eventAction: btnname})

    btnname2 = ''
    switch condition
      when 'Eczema, Psoriasis and Rash' then btnname += 'Eczema, Rash'
      when 'Skin Growth (Moles, Warts)' then btnname += 'Skin Growths'
      when 'Hairfall or Hair Thinning' then btnname += 'Hairfall'
      when 'Pigmentation, Tanning and Dark Circles' then btnname += 'Pigmentation'
      else btnname2 += condition
    btnname2 += ' Button'
    
    mixpanel.track("Button Clicked", {
      "Button Name": "Conditon Button",
      "Condition Name": btnname2,
      "Page URL": "consult/",
    });
    window._fbq.push(['track', 'Conditon Button Clicked',{'Condition Name':btnname2,'Page URL':'consult/'}]);
    window.location.href = '/consult/consultation_form/' + condition

  $("#new_patient")
    .on("ajax:success", (e, data, status, xhr) ->
      console.log 'First step clicked'
      currentFormStep++
      manageFormStepsVisibility()

      $('#my-form-step .form-stepper-2').on 'click', ->
        condition = $(this).attr('value')
        console.log condition
        btnname = 'click'
        switch condition
          when 'Eczema, Psoriasis and Rash' then btnname += 'Rash'
          when 'Skin Growth (Moles, Warts)' then btnname += 'SkinGrowths'
          when 'Stretch Marks' then btnname += 'StretchMarks'
          when 'Hairfall or Hair Thinning' then btnname += 'Hairfall'
          when 'Pigmentation, Tanning and Dark Circles' then btnname += 'Pigmentation'
          when 'General Skin Care' then btnname += 'GeneralSkinCare'
          else btnname += condition
        btnname += 'Button'
        ga('send', 'event', { eventCategory: 'consultation', eventAction: btnname})

        btnname2 = ''
        switch condition
          when 'Eczema, Psoriasis and Rash' then btnname += 'Eczema, Rash'
          when 'Skin Growth (Moles, Warts)' then btnname += 'Skin Growths'
          when 'Hairfall or Hair Thinning' then btnname += 'Hairfall'
          when 'Pigmentation, Tanning and Dark Circles' then btnname += 'Pigmentation'
          else btnname += condition
        btnname2 += ' Button'

        mixpanel.track("Button Clicked", {
          "Button Name": "Conditon Button",
          "Condition Name": btnname2,
          "Page URL": "consult/",
        });
        window._fbq.push(['track', 'Conditon Button Clicked',{'Condition Name':btnname2,'Page URL':'consult/'}]);
        window.location.href = '/consult/consultation_form/' + condition

    ).on "ajax:error", (e, xhr, status, error) ->
      $("#error_explanation").text "An error occurred. Please try again later."
      console.log e+ xhr+ status+ error