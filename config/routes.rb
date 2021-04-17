Rails.application.routes.draw do
  namespace :projects do
    resources :projects
  end

  root to: 'projects/projects#index'
end
