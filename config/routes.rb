Buttafly::Engine.routes.draw do

  resources :spreadsheets, :contents do
    resources :mappings
    member do
      patch 'archive'
      patch 'import'
      patch 'transmogrify'
    end
  end

  root to: "spreadsheets#index"
end
