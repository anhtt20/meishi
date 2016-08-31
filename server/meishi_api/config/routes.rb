Rails.application.routes.draw do
  # constraints subdomain: 'api' do

    scope module: 'api' do
      namespace :v1 do
        #API01
        post 'business_cards', to: 'business_cards#create'#, as: 'create_business_card'
        #API02
        put 'business_cards/:id', to: 'business_cards#update'#, as: 'edit_business_card'
        #API03
        get 'business_cards/:id', to: 'business_cards#show'#, as: 'get_business_card'
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
        #API-Register
        post 'sign_up', to: 'users#sign_up'
        end
    end
  # end
end
