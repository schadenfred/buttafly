Buttafly::Engine.routes.draw do
  get 'contents/index'

  resources :contents do
    member do
      patch 'archive'
      patch 'import'
      patch 'transmogrify'
    end
  end

  root to: "contents#index"
end
