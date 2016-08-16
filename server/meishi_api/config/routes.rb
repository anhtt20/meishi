Rails.application.routes.draw do
  constraints subdomain: 'api' do

    scope module: 'api' do
      namespace :v1 do
        #API07
        post 'sign_in', to: 'users#sign_in'
        delete 'sign_out', to: 'users#sign_out'
        # resources :roles
        # get 'current', to: 'roles#current'
      end
    end
  end
end
