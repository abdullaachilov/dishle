Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get "today", to: "puzzles#today"
      post "guess", to: "puzzles#guess"
      get "reveal", to: "puzzles#reveal"
      post "hint", to: "hints#create"
      get "dishes/search", to: "dishes#search"
      get "translations", to: "translations#index"

      post "auth/register", to: "auth#register"
      post "auth/login", to: "auth#login"
      delete "auth/logout", to: "auth#logout"
      get "auth/me", to: "auth#me"

      post "game_results", to: "game_results#create"
      get "leaderboard", to: "leaderboard#index"

      post "feedback", to: "feedbacks#create"
    end
  end

  get "*path", to: "static#index", constraints: ->(req) { !req.xhr? && req.format.html? }
  root "static#index"
end
