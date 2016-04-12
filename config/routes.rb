Rails.application.routes.draw do
  get '/' => 'gurls#new'
  get '/generate' => 'gurls#new'
  post '/gurls' => 'gurls#create'
  get '/:id' => 'gurls#redirect'
  get '/generate/:gatorly' => 'gurls#show'
end
