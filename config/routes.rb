Rails.application.routes.draw do
  resources :todos do
    member do
      post :add_tag
    end
  end
  resources :tags
end