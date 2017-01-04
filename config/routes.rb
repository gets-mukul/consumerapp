Rails.application.routes.draw do

  post '/patients' => 'patients#create', defaults: {format: 'json'}

  get '/consultation', to: 'consultation#welcome'
  get '/consultation_form/:condition', to: 'consultation#consultation_form'
  get '/new_patient', to: 'consultation#index'

  get '/payment', to: 'payment#index'
  post '/payment', to: 'payment#issue_payment'
  scope 'payment' do
    post '/success', to: 'payment#success'
    post '/failure', to: 'payment#failure'
  end

  get '/privacy_policy', to: 'static_pages#privacy_policy'
  get '/terms_of_use', to: 'static_pages#terms_of_use'

  root 'consultation#welcome'

end
