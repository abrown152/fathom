Rails.application.routes.draw do

  root 'requests#analyze'
  get '/analyze', :to => 'requests#analyze', as: 'analyze'
  post '/analyze', :to => 'requests#analyzed', as: 'analyzed'

  get '/about', :to => 'requests#about', as: 'about'

  post '/search', :to => 'requests#search', as: 'search'

  get '/trends', :to => 'requests#trends', as: 'trends'

  get '/show', :to => 'requests#show'


end
