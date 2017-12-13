Rails.application.routes.draw do
  scope '/consult' do
    get '/promo/:promo_code' => 'coupon#apply'

    post '/patients' => 'patients#create', defaults: {format: 'json'}
    get '/patients' => 'patients#create', defaults: {format: 'json'}

    get '/patients/instant_login' => 'patients#instant_login', defaults: {format: 'json'}
    post '/patients/set_patient_email' => 'patients#set_patient_email', defaults: {format: 'json'}

    post '/patients/:coupon' => 'patients#create_with_coupon', defaults: {format: 'json'}
    get '/patients/:coupon' => 'patients#create_with_coupon', defaults: {format: 'json'}

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
    get '/', to: 'consultation#index'
    
    get '/selfie_form', to: 'selfie_form#new'
    get '/selfie_form/new', to: 'selfie_form#new'
    post '/selfie_form/create', to: 'selfie_form#create', defaults: {format: 'json'}
    get '/selfie_form/thank_you', to: 'selfie_form#thank_you'
    get '/selfie-diagnosis', to: 'selfie_form#selfie_diagnosis'
  end
  
  scope '/docsapp' do
    devise_for :doctor, path: 'doctor', controllers: {
      sessions: 'doctors/sessions',
      registrations: 'doctors/registrations'
    }

    devise_scope :doctor do
      authenticated :doctor do
        root to: 'docsapp/dashboard#index', as: 'authenticated_doctor_root'
      end
      unauthenticated :doctor do
        root to: 'doctors/sessions#new', as: 'unauthenticated_doctor_root'
      end
      root to: 'doctors/sessions#new', as: 'doctor_root'
      get '/sign_out', to: 'doctors/sessions#destroy'
    end
    get 'dashboard', to: 'docsapp/dashboard#index'
    get 'diagnose', to: 'docsapp/dashboard#diagnose_selfie'
    post '/save_condition', to: 'docsapp/dashboard#save_condition'
  end
  
  scope '/internal' do
    devise_for :admin_users, path: 'admin', controllers: {
      sessions: 'admin_users/sessions',
      registrations: 'admin_users/registrations'
    }
    ActiveAdmin.routes(self)
  
    scope '/admin' do
      devise_scope :admin_user do
        authenticated :admin do
          root to: 'dashboard#index', as: 'authenticated_admin_user_root'
        end
    
        unauthenticated :admin do
          root to: 'admin_users/sessions#new', as: 'unauthenticated_admin_user_root'
        end
        get '/sign_out', to: 'admin_users/sessions#destroy'
      end
    end
  end
  
end

