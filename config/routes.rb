Buttafly::Engine.routes.draw do

  resources :legends
  resources :spreadsheets do
    resources :mappings
    member do
      patch 'archive'
      patch 'import'
      patch 'transmogrify'
    end
  end

  root to: "spreadsheets#index"
end
