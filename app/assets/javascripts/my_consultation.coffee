$ ->

  $('#my-form-step-reversed .form-stepper-2').on 'click', ->
    condition = $(this).attr('value')
    ga('send', 'event', { eventCategory: 'rev-consultation', eventAction: 'rev-clickConditionButton'});
    window._fbq.push(['track', 'Reverse Conditon Button Clicked',{'Page URL':'my_consultation/'}]);
    window.location.href = '/my_consultation/save_condition/' + condition
