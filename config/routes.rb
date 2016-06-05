Rails.application.routes.draw do

  root 'requests#index'
  post '/request', :to => 'requests#analyze', as: 'analyze'

  get '/about', :to => 'requests#about', as: 'about'

end
