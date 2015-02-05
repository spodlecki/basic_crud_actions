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
end
