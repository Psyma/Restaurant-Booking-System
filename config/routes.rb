Rails.application.routes.draw do    
    devise_for :users, :controllers => {  
        :omniauth_callbacks => 'users/omniauth_callbacks',  
        #:sessions => 'users/sessions',
        #:registrations => 'users/registrations',
        :passwords => 'users/passwords',
        :confirmations => 'users/confirmations'
    } 

    resources :products 

    get "/home", to: "home_page#index"
    patch "/home", to: "home_page#update"
    get "/about", to: "about_page#index"
    get "/service", to: "service_page#index"
    get "/menu", to: "menu_page#index"
    get "/contact", to: "contact_page#index"

    get "/bookings", to: "bookings_page#index"
    patch "/bookings", to: "bookings_page#confirm"
    put "/bookings", to: "bookings_page#decline" 
    
    get "/login", to: "sessions#index"
    post "/login", to: "sessions#login"
    delete "/logout", to: "sessions#logout"

    get "/registrations", to: "registrations#index"
    post "/registrations", to: "registrations#create"

    get "/reservations", to: "reservations#index" 
    patch "/reservations", to: "reservations#update"  

    get "/payments", to: "payments#index"
    post "/payments", to: "payments#create"
    patch "/payments", to: "payments#update"

    root "home_page#index"
end
