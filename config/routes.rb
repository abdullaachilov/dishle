Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "today", to: "puzzles#today"
      post "guess", to: "puzzles#guess"
      get "reveal", to: "puzzles#reveal"
      get "dishes/search", to: "dishes#search"
    end
  end

  get "*path", to: "static#index", constraints: ->(req) { !req.xhr? && req.format.html? }
  root "static#index"
end
