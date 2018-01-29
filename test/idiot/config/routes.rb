Rails.application.routes.draw do
  extend EngineRoutes
  root to: "static#home"
end
