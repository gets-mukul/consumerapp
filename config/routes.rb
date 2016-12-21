Rails.application.routes.draw do
  get 'payment/index'

  get '/consultation', to: 'consultation#welcome'
  get '/consultation_form', to: 'consultation#form'
  get '/index', to: 'consultation#index'
  get '/payment', to: 'payment#index'

  root 'home#index'

end
