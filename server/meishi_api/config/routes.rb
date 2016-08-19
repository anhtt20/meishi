Rails.application.routes.draw do
  # constraints subdomain: 'api' do

    scope module: 'api' do
      namespace :v1 do
        #API01
        post 'business_cards', to: 'business_cards#create'
        #API02
        put 'business_cards/:id', to: 'business_cards#update'
        #API03
        get 'business_cards/:id', to: 'business_cards#show'
        #API04
        get 'business_cards', to: 'business_cards#fetch'
        #API05
        delete 'business_cards/:id', to: 'business_cards#destroy'
        #API06
        get 'companies', to: 'companies#fetch'
        #API07
        post 'sign_in', to: 'users#sign_in'
        #API08
        delete 'sign_out', to: 'users#sign_out'
        #API09
        get 'departments', to: 'departments#fetch'

        end
    end
  # end
end
