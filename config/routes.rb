Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :trends, controller: :trends, defaults: { format: :json }, only: [:create, :index] do
        collection do
          get 'no_of_repos'
          get 'list_of_repos'
        end
      end
    end
  end
end
