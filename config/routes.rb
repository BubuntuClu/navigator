Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htm
  get 'navigator', to: 'navigator#index', as: 'navigator'
end
