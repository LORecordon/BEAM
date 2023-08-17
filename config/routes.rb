Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post "graphql", to: "graphql#execute"
      get 'users/:email', to: 'users#show', constraints: { email: /[^\/]+/ }, as: 'show_user_wemail'
      patch 'users/:email', to: 'users#update', constraints: { email: /[^\/]+/ }, as: 'update_user_wemail'
      get 'users/:email/edit', to: 'users#edit', constraints: { email: /[^\/]+/ }, as: 'edit_user_wemail'
      delete 'users/:email', to: 'users#destroy', constraints: { email: /[^\/]+/ }, as: 'destroy_user_wemail'
      post 'users', to: 'users#create', as: 'create_user'

      resources :api_keys, path: 'api-keys', only: %i[index create destroy]

      resources :trips, shallow: true do
        resources :posts, shallow: true
        resources :destinations
        resources :users
      end

      resources :destinations
      resources :posts
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
