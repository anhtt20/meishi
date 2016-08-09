Rails.application.routes.draw do
  #constraints subdomain: 'api' do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  scope module: 'api' do
    namespace :v1 do
      resources :roles
      get 'current', to: 'roles#current'
    end
  end
  #end
end
