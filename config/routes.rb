Buttafly::Engine.routes.draw do

  resources :artifacts, only: [:destroy] do
    member do
      patch 'revert'
    end
  end
  resources :legends

  resources :mappings do
    member do
      patch 'import'
      patch 'revert'
    end
  end
  resources :spreadsheets do
    resources :mappings
    resources :legends
    member do
      patch 'import'
      patch 'revert'
    end
  end

  root to: "spreadsheets#index"
end
