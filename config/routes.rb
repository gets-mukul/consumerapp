Rails.application.routes.draw do
  scope '/consult' do
    get '/promo/:promo_code' => 'coupon#apply'

    post '/patients' => 'patients#create', defaults: {format: 'json'}
    get '/patients' => 'patients#create', defaults: {format: 'json'}

    get '/patients/instant_login' => 'patients#instant_login', defaults: {format: 'json'}

    post '/patients/:coupon' => 'patients#create_with_coupon', defaults: {format: 'json'}
    get '/patients/:coupon' => 'patients#create_with_coupon', defaults: {format: 'json'}

    # get '/consultation', to: 'consultation#welcome'
    get '/consultation_form/:condition', to: 'consultation#consultation_form'
    get '/new_patient', to: 'consultation#index'
    get '/consultation/index_', to: 'consultation#index_page'
    get '/consultation/initiate', to: 'consultation#initiate'

    get '/payment', to: 'payment#index'
    post '/payment', to: 'payment#issue_payment'
    scope 'payment' do
      post '/payment_paytm', to: 'payment#issue_payment_paytm'
      post '/initiate_payment', to: 'payment#initiate_payment'

      post '/success', to: 'payment#success'
      post '/failure', to: 'payment#failure'
      get '/failure', to: 'payment#failure'
      get '/success_free', to: 'payment#success_free'
      get '/instant_payment' => 'payment#instant_payment', defaults: {format: 'json'}
    end

    get '/privacy_policy', to: 'static_pages#privacy_policy'
    get '/terms_of_use', to: 'static_pages#terms_of_use'
    #root 'consultation#welcome'
    get '/', to: 'consultation#index'
  end
  
  scope '/internal' do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end

  devise_for :doctors
end

