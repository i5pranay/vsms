Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'navigations#say_hello'
  resources :customers

  #match "user(/:user_identifier)" => "users#show_user", :via => 'get', :as => "show_user", :constraints => {:user_identifier => /[^\/]+/}
  match "helloruby" => "navigations#say_hello", :via => 'get', :as => "say_hello"

  match "new_sr" => "navigations#new_sr", :via => 'get', :as => "new_sr"
  match "create_sr" => "navigations#create_service_request", :via => 'post', :as => "create_sr"
  match "show_service_requests/:c_id" => "navigations#show_srs", :via => 'get', :as => "show_srs"
  match "new_sc_details" =>"adminpanels#new_sc_details", :via => 'get', :as => "new_sc_details"
  match "new_service_slots" =>"adminpanels#new_service_slots", :via => 'get', :as => "new_services_slots"
  match "new_service_types" =>"adminpanels#new_service_types", :via => 'get', :as => "new_services_types"
  match "create_sc_details" => "adminpanels#create_sc_details", :via => 'post', :as => "create_sc_details"
  match "create_service_slots" =>"adminpanels#create_service_slots", :via => 'post', :as => "create_service_slots"
  match "create_service_types" =>"adminpanels#create_service_types", :via => 'post', :as => "create_service_types"
  match "show_sc_details/:sc_id" => "adminpanels#show_sc_details", :via => 'get', :as => "show_sc_details"
  match "show_service_slots/:ss_id" => "adminpanels#show_service_slots", :via => 'get', :as => "show_service_slots"
  match "show_service_types/:st_id" => "adminpanels#show_service_types", :via => 'get', :as => "show_service_types"

  match "edit_profile" => "navigations#update_profile_view", :via => 'get', :as => "edit_profile"
  match "update_profile" => "navigations#update_profile", :via => 'post', :as => "update_profile"

  match "get_slots/:sevice_centre_id" => "navigations#get_slots_by_service_centre_id",:via => 'get'

























































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
