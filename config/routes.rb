Rails.application.routes.draw do

  root 'requests#index'
  get '/analyze', :to => 'requests#analyze', as: 'analyze'
  post '/analyze', :to => 'requests#analyzed', as: 'analyzed'

  get '/about', :to => 'requests#about', as: 'about'

end
