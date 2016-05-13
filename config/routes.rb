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
  resources :groups
  resources :course_elements
  resources :course_element_materials

  post 'sms_deliveries/:id/send' => 'sms_deliveries#send_message', as: 'sms_send_message'
  get 'select_objects/select_group/:id' => 'select_objects#select_group', as: 'select_groups'
  get 'select_objects/select_students/:id' => 'select_objects#select_students', as: 'select_students'
  get 'sms_deliveries/new_from_contact_list/:id' => 'sms_deliveries#new_from_contact_list', as: 'sms_new_from_contact_list'
  get 'sms_deliveries/resend_message/:id' => 'sms_deliveries#resend_message', as: 'sms_resend'
# SMSs
  get 'messages' => 'sms_deliveries#message_index', as: 'show_messages_index'
  get 'send_sms/:id' => 'sms_deliveries#send_sms', as: 'send_sms'


  get 'download_pasport/:id' => 'users#download_passport', as: 'download_passport'

# COURSES
  get 'course_index/:id' => 'courses#course_index', as: 'show_course_index'
  get 'course_groups/:id' => 'courses#course_groups', as: 'show_course_groups'
  get 'get_course_elements/:id' => 'courses#course_elements', as: 'get_course_elements'
  get 'course_periods/:id' => 'courses#group_periods', as: 'show_group_periods'
  get 'group_students/:id' => 'courses#group_index', as: 'show_group_index'
  get 'courses_list' => 'courses#courses_list', as: 'show_courses_list'
  get 'students_list' => 'courses#students_list', as: 'show_students_list'
  get 'study_units_list/:id' => 'courses#group_study_units', as: 'show_group_study_units'
  get 'get_group_students/:id' => 'courses#render_group_students', as: 'render_group_students'
  get 'get_performance_chart/:id' => 'courses#render_performance_chart', as: 'render_performance_chart'
  get 'get_student_homeworks_stats/:id' => 'courses#student_homeworks_data', as: 'show_student_homeworks_stats'


end
