Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(:module => "V1", :path => {:value => "v1"}) do

    get '/actuals/delete', to: 'actuals#delete'
    get '/profiles/search', to: 'profiles#search'
    put '/profiles', to: 'profiles#update'
    get '/profiles/my', to: 'profiles#my'

    post '/roles/abilities', to: 'roles#abilities'
    get '/roles/abilities/delete', to: 'roles#remove_ability'

    resources :profiles
    resources :channels
    resources :posts
    resources :roles
    resources :shares
    resources :uploads
    resources :auxiliary_tables
    resources :auxiliary_records
    resources :interactions
    resources :users
    resources :comments
    resources :metas
    resources :actuals


    post '/users/assignments', to: 'users#assignments'
    get '/users/assignments/delete', to: 'users#delete_assignment'
    post '/users/login', to: 'users#login'
    post '/users/sign_up', to: 'users#sign_up'

  end
end