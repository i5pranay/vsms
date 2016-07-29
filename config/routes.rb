Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'navigations#say_hello'
  resources :customers

  #match "user(/:user_identifier)" => "users#show_user", :via => 'get', :as => "show_user", :constraints => {:user_identifier => /[^\/]+/}
  match "helloruby" => "navigations#say_hello", :via => 'get', :as => "say_hello"

  match "get_service_types" => "navigations#get_service_type_by_id", :via => 'get'
  match "get_slots/:sevice_centre_id" => "navigations#get_slots_by_service_centre_id",:via => 'get'
  match "edit_profile" => "navigations#update_profile_view", :via => 'get', :as => "edit_profile"
  match "update_profile" => "navigations#update_profile", :via => 'post', :as => "update_profile"

  match "customer/new_sr" => "navigations#new_sr", :via => 'get', :as => "new_sr"
  match "customer/create_sr" => "navigations#create_service_request", :via => 'post', :as => "create_sr"
  match "customer/show_cusreq_details" => "navigations#show_srs", :via => 'get', :as => "show_srs"
  # show service request of customer and all its detail in listing
  match "customer/list_service_requests" => "navigations#list_service_requests", :via => 'get', :as => 'list_sr'

  match "sco/new_sc_details" =>"adminpanels#new_sc_details", :via => 'get', :as => "new_sc_details"
  match "sco/new_service_slots" =>"adminpanels#new_service_slots", :via => 'get', :as => "new_services_slots"
  match "sco/new_service_types" =>"adminpanels#new_service_types", :via => 'get', :as => "new_services_types"
  match "sco/create_sc_details" => "adminpanels#create_sc_details", :via => 'post', :as => "create_sc_details"

  match "sco/edit_sc_detail" => "adminpanels#edit_sc_details", :via => 'get' , :as =>  "form_edit_sc_detail"
  match "sco/edit_sc_detail" => "adminpanels#update_edit_sc_details", :via => 'post' , :as =>  "edit_sc_detail"
  #destroy centre
  match "sco/destroy_sc_detail" => "adminpanels#destroy_sc_detail" , :via => 'delete'

  match "sco/create_service_slots" =>"adminpanels#create_service_slots", :via => 'post', :as => "create_service_slots"
  match "sco/create_service_types" =>"adminpanels#create_service_types", :via => 'post', :as => "create_service_types"
  #edit service type
  match "sco/edit_service_type" => "adminpanels#edit_service_type_view", :via => 'get', :as => "edit_st_view"
  match "sco/edit_service_type" => "adminpanels#edit_service_type", :via => 'post', :as => "edit_st"

  #destroy service type
  match "sco/destroy_service_type" => "adminpanels#destroy_service_type" , :via => 'delete'

  match "sco/show_sc_details/:sc_id" => "adminpanels#show_sc_details", :via => 'get', :as => "show_sc_details"
  match "sco/show_service_slots/:ss_id" => "adminpanels#show_service_slots", :via => 'get', :as => "show_service_slots"
  match "sco/show_service_types/:st_id" => "adminpanels#show_service_types", :via => 'get', :as => "show_service_types"
  match "sco/destroy_service_slot" =>  "adminpanels#destroy_service_slot", :via =>  'delete'
  #show service request of centreowner/admin
  match "sco/list_admin_sr" => "adminpanels#list_admin_sr", :via => 'get' , :as => "list_admin_sr"
  match "sco/edit_slot" => "adminpanels#edit_service_slot_view", :via => 'get' , :as => "form_edit_slot"
  match "sco/edit_slot" => "adminpanels#edit_service_slot", :via => 'post' , :as => "edit_slot"
  match "sco/update_service_request" => "adminpanels#update_service_request_view", :via => 'get', :as => "updtae_sr"
  match "sco/update_service_request" => "adminpanels#update_service_request", :via => 'post', :as => "updtae_servreq"

  namespace :super_admin do
    match "update_user" => "superadmins#update_user_role_view", :via => 'get', :as => 'update_user'
    match "update_user" => "superadmins#update_user_role", :via => 'put'
  end

  #show all the service types,slots,and service centre of present owner
  #match "owner_index" => "adminpanels#owner_index", :via => 'get' , :as => "owner_index"





























































  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
