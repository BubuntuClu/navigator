Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htm
  get 'navigator', to: 'navigator#index', as: 'navigator'
  get 'navigator/bd_table', to: 'navigator#bd_table', as: 'navigator_bd_table'
  get 'navigator/ruby_table', to: 'navigator#ruby_table', as: 'navigator_ruby_table'
end
