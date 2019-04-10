Rails.application.routes.draw do
  get 'navigator', to: 'navigator#index', as: 'navigator'
  get 'navigator/show_distance', to: 'navigator#show_distance', as: 'navigator_show_distance'
end
