Rails.application.routes.draw do
  root "jobs#index"
  get "jobs/refresh", to: "jobs#refresh"
end
