Buttafly::Engine.routes.draw do
  resources :contents do
    member do 
      patch 'archive'
      patch 'import'
      patch 'transmogrify'
    end
  end
end
