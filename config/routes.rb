Rails.application.routes.draw do
  
  get 'welcome/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :products, controller: "my_products" do
  	resources :has_nutrients, only: [:create]
  end

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :products, controller: "products", only: [:show]
      resources :app_users, controller: "app_users", only: [:create, :update]
    end
  end
  
  devise_for :users, :controllers => { :registrations => "users"}
  as :user do
    get "/users" => "users#index", :as => :user_index
    delete "/users/:id_user" => "users#destroy", :as => :user_destroy
  end

  resources :companies, only: [:new, :edit, :create,:update]

  namespace :api, defaults: { format: "json" } do
  	namespace :v1 do
  		resources :products, controller: "products", only: [:show]
      resources :app_users, olny: [:create]
  	end
  end
  
end
