Rails.application.routes.draw do

  scope '/consult' do

    namespace :api, defaults: {format: 'json'} do
      namespace :v1 do

        get 'coupon/apply/:promo_code' => 'coupon#apply', :as => 'coupon_apply'

        # patients
        post 'patient/create' => 'patient#create'
        get 'patient/create' => 'patient#create'
        get 'patient/unregister' => 'patient#unregister_patient', :as => 'unregister_patient'

        # consultations
        get 'consultations' => 'consultation#fetch_consultations'

        # selfie form
        post 'selfie-form/create' => 'selfie_form#create'
        get 'selfie-form/get-skin-type-quiz' => 'selfie_form#get_skin_type_quiz'
        get 'selfie-form/get-diagnosis/:selfie_id' => 'selfie_form#get_diagnosis', :as => 'selfie_form_get_diagnosis_path'
        post 'selfie-form/save-my-skin-type' => 'selfie_form#save_my_skin_type'
        get 'selfie-form/save-my-skin-type' => 'selfie_form#save_my_skin_type'

        # questionnaire
        get 'questionnaire/:condition' => 'questionnaire#index'

        # questionnaire_responses
        post 'questionnaire_response/save' => 'questionnaire_response#save'

        if Rails.env.development?
          get '/patients/get_patient_details' => 'patient#get_patient_details'
        end

        get 'get-s3-policy' => 's3_bucket#get_s3_policy'
      end
    end

    get '/promo/:promo_code' => 'coupon#apply'

    post '/patients' => 'patients#create', defaults: {format: 'json'}
    get '/patients' => 'patients#create', defaults: {format: 'json'}

    get '/patients/instant_login' => 'patients#instant_login', defaults: {format: 'json'}
    post '/patients/set_patient_email' => 'patients#set_patient_email', defaults: {format: 'json'}
    get '/patients/coupon_login/' => 'patients#login_with_coupon', defaults: {format: 'json'}

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
      post '/payment_paytm_update', to: 'payment#payment_paytm_update'
      post '/initiate_payment', to: 'payment#initiate_payment'

      post '/success', to: 'payment#success'
      post '/failure', to: 'payment#failure'
      get '/failure', to: 'payment#failure'
      get '/flag', to: 'payment#flag'
      get '/pending', to: 'payment#pending'
      get '/success_free', to: 'payment#success_free'
      get '/instant_payment' => 'payment#instant_payment', defaults: {format: 'json'}
    end
    get '/payment/:type', to: 'payment#index'

    get '/privacy_policy', to: 'static_pages#privacy_policy'
    get '/terms_of_use', to: 'static_pages#terms_of_use'
    get '/', to: 'consultation#index'
    
    get '/selfie_form', to: redirect('/selfie-form')
    get '/selfie_form/new', to: redirect('/selfie-form')
    get '/selfie-diagnosis', to: redirect('/selfie-diagnosis')
    # get '/selfie_form', to: '/selfie-checkup-form'
    # get '/selfie_form/new', to: '/selfie-checkup-form'

    # get '/selfie_form', to: 'selfie_form#new'
    # get '/selfie_form/new', to: 'selfie_form#new'
    # post '/selfie_form/create_image', to: 'selfie_form#create_image', defaults: {format: 'json'}
    # post '/selfie_form/create_patient', to: 'selfie_form#create_patient', defaults: {format: 'json'}
    # get '/selfie_form/thank_you', to: 'selfie_form#thank_you'
    # get '/selfie-diagnosis', to: 'selfie_form#selfie_diagnosis'
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

        require 'sidekiq/web'
        mount Sidekiq::Web => '/sidekiq-usage/sidekiq'

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

  scope '/my_consultation' do
    post '/create' => 'my_consultation#create'
    get '/create' => 'my_consultation#create'
    get '/save_condition/:condition' => 'my_consultation#save_condition'
    get '/payment', to: 'my_consultation#payment'
    post '/initiate_payment', to: 'my_consultation#initiate_payment'
    post '/payment_paytm_update', to: 'my_consultation#payment_paytm_update'
    post '/payment_success', to: 'my_consultation#payment_success'
    get '/payment_success', to: 'my_consultation#continue_consultation'
    get '/consultation_form/:condition', to: 'my_consultation#consultation_form'
    get '/success', to: 'my_consultation#success'
    get '/failure', to: 'my_consultation#failure'
    get '/flag', to: 'my_consultation#flag'
  end
end
