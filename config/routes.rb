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
  	end
  end
  
end
