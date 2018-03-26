Rails.application.routes.draw do
  root 'wellcome#index'
  
  get 'index' => 'wellcome#index'
  post 'index' => 'wellcome#index'

  get 'test' => 'wellcome#test'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
