Rails.application.routes.draw do
  #constraints subdomain: 'api' do
  
  scope module: 'api' do
    namespace :v1 do
      #API07
      post 'sign_in', to: 'users#sign_in'
      # resources :roles
      # get 'current', to: 'roles#current'
    end
  end
  #end
end
