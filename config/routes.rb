Rails.application.routes.draw do
  scope '/admin' do
    resources :patients, except: [:new, :create]
  end

  post '/patients' => 'patients#create', defaults: {format: 'json'}

  get '/consultation', to: 'consultation#welcome'
  get '/consultation_form/:condition', to: 'consultation#consultation_form'
  get '/new_patient', to: 'consultation#index'
  get '/payment', to: 'payment#index'
  get '/success', to: 'payment#success'

  root 'home#index'

end
