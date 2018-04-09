Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :todo_lists do
  #   member do
  #     post :add_task
  #   end
  # end

  namespace :api do
    namespace :v1 do
      resources :todo_lists do
        member do
          post :add_task
        end
      end
    end
  end


  match "*path", to: "application#no_route_found", via: :all
end
