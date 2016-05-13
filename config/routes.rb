Rails.application.routes.draw do
  root 'courses#index'

  devise_for :users
  scope :member do
    resources :users
  end

  resources :contact_lists,
            :sms_deliveries,
            :sms_service_accounts
  resources :senders

  resources :custom_lists do
    collection {post :import}
  end

  resources :courses

  post 'sms_deliveries/:id/send' => 'sms_deliveries#send_message', as: 'sms_send_message'
  get 'select_objects/select_group/:id' => 'select_objects#select_group', as: 'select_groups'
  get 'select_objects/select_students/:id' => 'select_objects#select_students', as: 'select_students'
  get 'sms_deliveries/new_from_contact_list/:id' => 'sms_deliveries#new_from_contact_list', as: 'sms_new_from_contact_list'
  get 'sms_deliveries/resend_message/:id' => 'sms_deliveries#resend_message', as: 'sms_resend'
# SMSs
  get 'messages' => 'sms_deliveries#message_index', as: 'show_messages_index'
  get 'send_sms/:id' => 'sms_deliveries#send_sms', as: 'send_sms'


  get 'download_pasport/:id' => 'users#download_passport', as: 'download_passport'

end
