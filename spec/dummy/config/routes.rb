Rails.application.routes.draw do
  resources :test_models
  resources :short_test_models
  post '/create_fail' => 'test_models#create_fail'
  post '/update_fail' => 'test_models#update_fail'
  put '/update' => 'test_models#update'
  get '/test_save' => 'test_models#test_save'
  get '/test_save_bang' => 'test_models#test_save_bang'
  get '/test_save_invalid' => 'test_models#test_save_invalid'
  get '/test_save_bang_invalid' => 'test_models#test_save_bang_invalid'
  post 'short/create_fail' => 'short_test_models#create_fail'
  post 'short/update_fail' => 'short_test_models#update_fail'
  put 'short/update' => 'short_test_models#update'
  get 'short/test_save' => 'short_test_models#test_save'
  get 'short/test_save_bang' => 'short_test_models#test_save_bang'
  get 'short/test_save_invalid' => 'short_test_models#test_save_invalid'
  get 'short/test_save_bang_invalid' => 'short_test_models#test_save_bang_invalid'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
