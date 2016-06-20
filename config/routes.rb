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
  resources :course_element_files, only: [:show, :create, :destroy]
  resources :periods
  resources :study_units

  get 'periods/:period_id/material_theme/:id' => 'periods#show_material', as: 'show_student_theme_materials'
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

  delete 'destroy_user_from_group/group/:group_id/user/:user_id' => 'courses#destroy_user_from_group', as: 'destroy_user_from_group'

#ADMIN-REPORTS
  get 'admin_reports_filters/' => 'admin_reports#admin_reports_filters', as: 'admin_reports_filters'
  get 'admin_reports_attendance' => 'admin_reports#attendance_report_table'
  get 'admin_reports_homework' => 'admin_reports#homework_report_table'
  get 'admin_reports_attendance_unit/:id' => 'admin_reports#attendance_current_study_unit'
  get 'admin_reports_homework_unit/:id' => 'admin_reports#homework_current_study_unit'
  get 'admin_reports_homework_previous_unit/:id' => 'admin_reports#homework_previous_study_unit'
  get 'admin_reports_attendance_previous_unit/:id' => 'admin_reports#attendance_previous_study_unit'
  get 'admin_reports_attendance_ed_unit/:id' => 'admin_reports#attendance_educational_unit'
  get 'admin_reports_homework_ed_unit/:id' => 'admin_reports#homework_educational_unit'
  get 'admin_reports_sorting_by_date/:id' => 'admin_reports#sort_by_date', as: 'admin_reports_sort_by_date'
  get 'admin_total_attendance/:id' => 'admin_reports#get_student_total_attendance'

# forms for teacher`s feedback
  get 'teacher_hws/send_feedback/:id' => 'teacher_hws#send_feedback', as: 'send_feedback'
  get 'teacher_hws/edit_feedback/:id' => 'teacher_hws#edit_feedback', as: 'edit_feedback'
  get 'teacher_hws/send_extra_feedback/:id' => 'teacher_hws#send_extra_feedback', as: 'send_extra_feedback'
  get 'teacher_hws/edit_extra_feedback/:id' => 'teacher_hws#edit_extra_feedback', as: 'edit_extra_feedback'
  get 'teacher_hws/edit_from_modal/:id' => 'teacher_hws#edit_from_modal', as: 'edit_from_modal'

# update teacher`s feedback
  put 'teacher_hws/create_feedback/:id' => 'teacher_hws#create_feedback', as: 'create_feedback'
  put 'teacher_hws/create_feedback_for_extra_hw/:id' => 'teacher_hws#create_feedback_for_extra_hw',
      as: 'create_feedback_for_extra_hw'

# downloads
  get 'download/:id' => 'teacher_hws#download_hw', as: 'download_zip'
  get 'download_extra_hw/:id' => 'teacher_hws#download_extra_hw', as: 'download_extra_hw'
  get 'exports' => 'teacher_hws#export_all', as: 'export_all'

  get 'users/group/:group_id/period/:period_id' => 'teacher_hws#students_index', as: 'students_by_teacher'
  get 'users_date/group/:group_id/period/:period_id' => 'teacher_hws#students_index_date', as: 'students_date_index'
  get 'periods/:id' => 'teacher_hws#periods_index', as: 'periods_by_teacher'

end
